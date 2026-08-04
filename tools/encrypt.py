#!/usr/bin/env python3
"""
Vanity-General payload encrypter — final release stage.

Encrypts the (already bundled + obfuscated) Lua file into a self-decrypting
stub: the payload ships as XOR-encrypted byte tables under a random per-build
key, and a small loader decrypts it in memory and loadstrings it. The file on
disk (and the body the loader fetches over HTTP) contains no readable Lua at
all — no strings, no structure, no comments.

This is a deterrence layer, not cryptography: the key ships next to the
payload, so a determined reverser can decrypt it. It defeats grepping, casual
reading, and signature scans on the released file.

Usage:
    python tools/encrypt.py <input.lua> <output.lua>

The stub needs bit32 (present in Luau). Like tools/obfuscate.py, the output
is verified before writing: the encrypted bytes are decrypted in Python and
compared against the input, and a mismatch aborts the build.
"""

import random
import sys


def chunk(nums, per_line=40):
    lines = []
    for i in range(0, len(nums), per_line):
        lines.append(",".join(str(n) for n in nums[i:i + per_line]))
    return ",\n".join(lines)


def main() -> None:
    if len(sys.argv) != 3:
        sys.exit("usage: python tools/encrypt.py <input.lua> <output.lua>")
    src_path, out_path = sys.argv[1], sys.argv[2]

    with open(src_path, "rb") as f:
        payload = f.read()

    key = [random.randrange(1, 256) for _ in range(random.randrange(24, 40))]
    enc = [b ^ key[i % len(key)] for i, b in enumerate(payload)]

    # Self-verify: decrypt the exact bytes we are about to ship.
    dec = bytes(b ^ key[i % len(key)] for i, b in enumerate(enc))
    if dec != payload:
        sys.exit("encrypt: self-check failed, refusing to write")

    stub = (
        "local _k={\n" + chunk(key) + "\n}\n"
        + "local _p={\n" + chunk(enc) + "\n}\n"
        + "local _x=bit32.bxor\n"
        + "local _c=string.char\n"
        + "local _n=#_k\n"
        + "local _t=table.create(#_p)\n"
        + "for _i=1,#_p do\n"
        + "\t_t[_i]=_c(_x(_p[_i],_k[(_i-1)%_n+1]))\n"
        + "end\n"
        + "local _f,_e=loadstring(table.concat(_t))\n"
        + "if not _f then error(_e) end\n"
        + "return _f()\n"
    )

    with open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(stub)
    print(f"ok: encrypted {len(payload)} bytes -> {out_path} ({len(stub)} bytes, key {len(key)}B)")


if __name__ == "__main__":
    main()
