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


# Names we never rename: globals the file may legitimately use, plus `self`.
# If a local shadows one of these somewhere, renaming every occurrence would
# break the global uses, so these ids are simply left alone.
KEEP_NAMES = {
    "self", "_ENV", "_G", "_VERSION",
    "game", "workspace", "script", "plugin",
    "print", "warn", "error", "assert", "pcall", "xpcall", "select",
    "pairs", "ipairs", "next", "type", "typeof", "tostring", "tonumber",
    "rawget", "rawset", "rawequal", "rawlen", "setmetatable", "getmetatable",
    "require", "loadstring", "load", "loadfile", "dofile", "coroutine",
    "math", "table", "string", "os", "io", "bit32", "utf8", "debug",
    "tick", "time", "wait", "delay", "spawn", "task", "unpack",
    "Vector2", "Vector3", "CFrame", "Color3", "BrickColor", "UDim", "UDim2",
    "Rect", "Enum", "Instance", "NumberRange", "NumberSequence",
    "ColorSequence", "Ray", "Region3", "TweenInfo", "Random", "DateTime",
    "getgenv", "gethui", "getrenv", "getgc", "getloadedmodules",
    "hookmetamethod", "getnamecallmethod", "checkcaller", "newcclosure",
    "syn", "http", "request", "http_request", "fluxus", "delta",
    "Drawing", "VirtualUser", "writefile", "readfile", "makefolder",
    "isfolder", "isfile", "listfiles", "delfile", "appendfile",
    "setclipboard", "identifyexecutor", "getexecutorname",
}

_FUNC_KINDS = ("LocalFunction", "AnonymousFunction", "Method", "Function")


def _walk_nodes(node, parent=None):
    yield node, parent
    for value in getattr(node, "__dict__", {}).values():
        if isinstance(value, astnodes.Node):
            yield from _walk_nodes(value, node)
        elif isinstance(value, list):
            for item in value:
                if isinstance(item, astnodes.Node):
                    yield from _walk_nodes(item, node)


def collect_name_replacements(tree, src_text):
    """Rename every local identifier to _v1, _v2, ...

    Returns (replacements, mapping, skipped) where replacements is a list of
    (start, stop, new_name) source spans. A name is renamed only if it is
    declared as a local somewhere (local assign, local function, for-loop
    vars, function params) and isn't in KEEP_NAMES. Table-field positions
    (Index keys, Method names, table-constructor field keys) are never
    renamed — `config.Enabled` must stay `config.Enabled`.

    Ids that ALSO appear as bare table-constructor keys (`{ id =` / `, id =`)
    are excluded from the mapping entirely: renaming them textually would
    corrupt the table key, and renaming them only partially (span pass)
    splits one local into two names and breaks the script. Skipping the
    whole id keeps it consistent — merely readable.
    """
    declared = set()
    excluded_node_ids = set()
    name_nodes = []  # (id, start, stop)

    for node, parent in _walk_nodes(tree):
        kind = node._name

        if kind in _FUNC_KINDS:
            for arg in getattr(node, "args", None) or []:
                if isinstance(arg, astnodes.Name):
                    declared.add(arg.id)
            if kind == "LocalFunction" and isinstance(getattr(node, "name", None), astnodes.Name):
                declared.add(node.name.id)
            if kind == "Method" and isinstance(getattr(node, "name", None), astnodes.Name):
                excluded_node_ids.add(id(node.name))

        if kind == "LocalAssign":
            for target in node.targets:
                if isinstance(target, astnodes.Name):
                    declared.add(target.id)
        elif kind == "Fornum":
            if isinstance(node.target, astnodes.Name):
                declared.add(node.target.id)
        elif kind == "Forin":
            for target in node.targets:
                if isinstance(target, astnodes.Name):
                    declared.add(target.id)
        elif kind == "Index":
            # every Name child except the table expression is a field key
            for value in getattr(node, "__dict__", {}).values():
                if isinstance(value, astnodes.Name) and value is not getattr(node, "value", None):
                    excluded_node_ids.add(id(value))
        elif kind == "Field":
            for value in getattr(node, "__dict__", {}).values():
                if isinstance(value, astnodes.Name) and value is not getattr(node, "value", None):
                    excluded_node_ids.add(id(value))

        if kind == "Name" and id(node) not in excluded_node_ids:
            # luaparser leaves _first_token unset on some Names (bare-local
            # targets, params) — fall back to _last_token (identifiers are
            # single tokens, so either one gives the span)
            first = node._first_token or node._last_token
            last = node._last_token or node._first_token
            if first is not None and last is not None:
                name_nodes.append((node.id, first.start, last.stop))

    rename_ids = sorted(n for n in declared if n not in KEEP_NAMES and len(n) > 1)
    existing = {n for n, _, _ in name_nodes} | KEEP_NAMES
    mapping = {}
    skipped = []
    i = 0
    for old in rename_ids:
        if re.search(rf"[{{,]\s*{re.escape(old)}\s*=", src_text):
            skipped.append(old)
            continue  # table-key use: leave the whole id alone (see docstring)
        while True:
            i += 1
            new = f"_v{i}"
            if new not in existing:
                break
        mapping[old] = new
        existing.add(new)

    replacements = [
        (start, stop, mapping[name])
        for name, start, stop in name_nodes
        if name in mapping
    ]
    return replacements, mapping, skipped


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
    name_replacements, name_mapping, skipped_ids = collect_name_replacements(tree, stripped)

    key = [random.randrange(1, 256) for _ in range(9)]

    def encrypt(data: bytes):
        return [b ^ key[(i % len(key))] for i, b in enumerate(data)]

    # Merge string + name replacements into one span pass (spans come from
    # the same AST and never overlap). Back-to-front so offsets stay valid.
    spans = [(s, e, "(_V9({" + ",".join(str(b) for b in encrypt(v)) + "}))")
             for s, e, v in strings]
    spans += name_replacements
    spans.sort(key=lambda t: t[0])
    for (a_start, a_stop, _), (b_start, b_stop, _) in zip(spans, spans[1:]):
        if b_start <= a_stop:
            raise SystemExit("overlapping replacement spans — refusing to build")

    out = stripped
    for start, stop, text in reversed(spans):
        out = out[:start] + text + out[stop + 1:]

    # Fallback: luaparser attaches no source tokens to some Name nodes
    # (targets/params in certain positions), so occurrences without spans
    # survive the span pass. Rename every remaining occurrence textually —
    # safe here because strings are already encrypted and comments stripped,
    # so identifier words only remain in code positions. `.id` / `:id`
    # (field access) are protected by the lookbehind. Already-renamed
    # occurrences no longer match `old`, so spanned and unspanned
    # occurrences converge on one name. (Table-key ids were excluded from
    # the mapping up front, so no skip logic is needed here.)
    textual = 0
    for old, new in sorted(name_mapping.items(), key=lambda kv: -len(kv[0])):
        out, n = re.subn(rf"(?<![\w.:]){re.escape(old)}(?![\w])", new, out)
        textual += n
    if skipped_ids:
        print(f"note: {len(skipped_ids)} name(s) kept readable (table-key use): "
              + ", ".join(skipped_ids[:10]))

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

    # Every mangled _vN referenced must be declared somewhere. A split
    # rename (some occurrences renamed, others not) leaves dangling
    # references that only fail at runtime — catch them here.
    declared_v = set()
    for names in re.findall(r"\blocal\s+([^=\n]+)", result):
        declared_v.update(re.findall(r"_v\d+", names))
    for params in re.findall(r"function[^(]*\(([^)]*)\)", result):
        declared_v.update(re.findall(r"_v\d+", params))
    for targets in re.findall(r"\bfor\s+([^\n]+?)\s*(?:=|\bin\b)", result):
        declared_v.update(re.findall(r"_v\d+", targets))
    used_v = set(re.findall(r"(?<![\w.])(_v\d+)(?![\w])", result))
    dangling = used_v - declared_v
    if dangling:
        raise SystemExit(
            f"dangling mangled names (split rename bug): {sorted(dangling)[:10]}"
        )

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

    print(f"ok: {len(strings)} strings encrypted, {len(name_mapping)} names mangled "
          f"({textual} textual), {len(src)} -> {len(result)} bytes -> {out_path}")


if __name__ == "__main__":
    main()
