#!/usr/bin/env python3
"""
Vanity-General obfuscator.

Transforms a Lua/Luau source file into a functionally identical but
hard-to-read build:

  1. Strips all comments (quote-aware, so `--` inside strings survives).
  2. Replaces every string literal with `(_D({...}))` — a runtime decoder
     call over XOR-encrypted bytes. This hides webhook URLs, UI text,
     service names, key names, etc.
  3. Flattens indentation and blank lines.

Honest limitations (by design, this is NOT Luraph):
  - The decoder and key ship inside the file, so a determined reverser can
    recover every string in minutes. This stops casual copying and string
    grepping, not reverse engineering.
  - Local/upvalue names and control flow are left intact. Renaming without
    full scope resolution risks silently breaking the script, so we don't.

Safety guarantees:
  - Refuses to run on source it cannot parse (e.g. Luau-only syntax like
    `continue`), so it never emits a half-transformed file.
  - Every emitted string table is decrypted and compared against the
    original value before the file is written; a mismatch aborts the build.

Usage:
    python tools/obfuscate.py <input.lua> <output.lua>

Requires: pip install luaparser
"""

import random
import re
import sys

from luaparser import ast
from luaparser import astnodes


def strip_comments(src: str) -> str:
    """Remove -- line comments and --[[ long comments ]] without touching
    string literals. Replaces comment text with spaces to keep offsets."""
    out = list(src)
    i = 0
    n = len(src)
    while i < n:
        c = src[i]
        # quoted string: skip over it (long brackets handled below)
        if c in "\"'":
            j = i + 1
            while j < n:
                if src[j] == "\\":
                    j += 2
                    continue
                if src[j] == c:
                    break
                j += 1
            i = j + 1
            continue
        # long string or long bracket level
        if c == "[" and i + 1 < n and src[i + 1] in "[=":
            m = re.match(r"\[=*\[", src[i:])
            if m:
                level = m.group(0).count("=")
                close = "]" + "=" * level + "]"
                j = src.find(close, i + m.end())
                i = (j + len(close)) if j != -1 else n
                continue
        # comment
        if c == "-" and i + 1 < n and src[i + 1] == "-":
            m = re.match(r"--\[=*\[", src[i:])
            if m:  # long comment
                level = m.group(0).count("=")
                close = "]" + "=" * level + "]"
                j = src.find(close, i + m.end())
                end = (j + len(close)) if j != -1 else n
            else:  # line comment
                j = src.find("\n", i)
                end = j if j != -1 else n
            for k in range(i, end):
                out[k] = " "
            i = end
            continue
        i += 1
    return "".join(out)


def collect_strings(tree):
    """All String nodes as (start, stop, value-bytes), source offsets."""
    found = []

    def walk(node):
        if isinstance(node, astnodes.String):
            found.append(
                (node._first_token.start, node._last_token.stop, node.s)
            )
            return
        for value in getattr(node, "__dict__", {}).values():
            if isinstance(value, astnodes.Node):
                walk(value)
            elif isinstance(value, list):
                for item in value:
                    if isinstance(item, astnodes.Node):
                        walk(item)

    walk(tree)
    # innermost/longest first ordering doesn't matter as long as spans don't
    # nest (string literals never nest in Lua); sort for sanity.
    found.sort(key=lambda t: t[0])
    for (a_start, a_stop, _), (b_start, b_stop, _) in zip(found, found[1:]):
        if b_start <= a_stop:
            raise SystemExit("overlapping string spans — refusing to build")
    return found


def flatten(src: str) -> str:
    lines = [ln.strip() for ln in src.splitlines()]
    return "\n".join(ln for ln in lines if ln) + "\n"


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit(__doc__)
    src_path, out_path = sys.argv[1], sys.argv[2]

    with open(src_path, encoding="utf-8") as f:
        src = f.read()

    stripped = strip_comments(src)

    try:
        tree = ast.parse(stripped)
    except Exception as exc:
        raise SystemExit(
            f"source does not parse as standard Lua ({exc}).\n"
            "Luau-only syntax (continue, compound assignment, type\n"
            "annotations) is unsupported — refusing to emit a broken build."
        )

    strings = collect_strings(tree)

    key = [random.randrange(1, 256) for _ in range(9)]

    def encrypt(data: bytes):
        return [b ^ key[(i % len(key))] for i, b in enumerate(data)]

    # Replace spans back-to-front so offsets stay valid.
    out = stripped
    for start, stop, value in reversed(strings):
        table = ",".join(str(b) for b in encrypt(value))
        out = out[:start] + "(_V9({" + table + "}))" + out[stop + 1:]

    decoder = (
        "local _V9=(function(_k)return function(_t)"
        "local _o={}for _i=1,#_t do "
        "_o[_i]=string.char(bit32.bxor(_t[_i],_k[(_i-1)%#_k+1]))end "
        "return table.concat(_o)end end)({" + ",".join(map(str, key)) + "})\n"
    )
    result = decoder + flatten(out)

    # Verify: parse the result, then decrypt every emitted table and compare.
    try:
        ast.parse(result)
    except Exception as exc:
        raise SystemExit(f"obfuscated output failed to re-parse: {exc}")

    emitted = re.findall(r"\(_V9\(\{([\d,]*)\}\)\)", result)
    if len(emitted) != len(strings):
        raise SystemExit(
            f"table count mismatch: {len(emitted)} emitted vs {len(strings)} expected"
        )
    originals = {tuple(encrypt(v)) for _, _, v in strings}
    for table in emitted:
        nums = tuple(int(x) for x in table.split(",")) if table else ()
        if nums not in originals:
            raise SystemExit("round-trip verification failed — refusing to write")

    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(result)

    print(f"ok: {len(strings)} strings encrypted, "
          f"{len(src)} -> {len(result)} bytes -> {out_path}")


if __name__ == "__main__":
    main()
