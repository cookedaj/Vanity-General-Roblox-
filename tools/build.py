#!/usr/bin/env python3
"""
Vanity-General bundler — generates the single-file executor build
(dist/VanityGeneral_INTEGRATED.lua) from the modular sources in src/.

Module contract the bundler relies on:
  - Each module file defines its table and ends with `return <TableName>`.
  - Cross-module references are top-of-file `local X = require(script.Y)`.
  - Modules are siblings in src/.

Transform per module:
  - `local X = require(script.Y)` becomes `local X = Y` (Y is hoisted).
  - The trailing `return <Table>` line is dropped and replaced with
    `<ModuleName> = <Table>` just before the block closes (so the internal
    table name doesn't have to match the file name).
  - The body is wrapped in `do ... end` so its private locals are released —
    this is what keeps the bundle under Luau's 200-local register limit.
  - Module table locals are hoisted to bundle top-level.

Usage:
    python tools/build.py [src_dir] [out_file]
"""

import re
import sys

# Bundle order = require dependency order. Every module listed must exist.
MODULES = [
    "Configuration",
    "ConfigManager",
    "Utility",
    "CameraDirector",
    "ESP",
    "DrawingESP",
    "Visuals",
    "Webhook",
    "Triggerbot",
    "SilentAim",
    "Hitbox",
    "NoRecoil",
    "NoSpread",
    "UI",
    "Movement",
    "Controller",
    "Main",
]

HEADER = """--==============================================================================
-- VANITY-GENERAL - FULLY INTEGRATED BUILD
-- GENERATED FILE - do not edit. Edit src/ and re-run tools/build.py.
--
-- Usage:
--   local VanityGeneral = loadstring(readfile("VanityGeneral_INTEGRATED.lua"))()
--   VanityGeneral.Start()
--   -- VanityGeneral.Stop() to tear down
--   -- VanityGeneral.Toggle() to toggle start/stop
--
-- Keys: RightShift = menu | LeftAlt = camera tracking | End = unload
--==============================================================================
"""


def transform(name: str, body: str) -> str:
    lines = body.split("\n")

    out = []
    for line in lines:
        # requires become aliases to the hoisted locals
        m = re.match(r"^(\s*)local\s+(\w+)\s*=\s*require\(script\.(\w+)\)\s*$", line)
        if m:
            indent, alias, mod = m.groups()
            if mod not in MODULES:
                raise SystemExit(f"{name}: requires unknown module '{mod}' (add to MODULES)")
            out.append(f"{indent}local {alias} = {mod}")
            continue
        out.append(line)

    # Main is the entry chunk, not a table module: its trailing
    # `return Controller` must SURVIVE so `loadstring(bundle)()` evaluates
    # to the API table. Other modules: wrap in an immediately-invoked
    # function whose `return X` feeds the hoisted module local. (A plain
    # do...end + trailing assignment would self-assign the block-local
    # table that shadows the hoisted one.)
    if name == "Main":
        body_out = "\n".join(out)
        indented = "\n".join(
            ("\t" + ln) if ln.strip() else ln for ln in body_out.split("\n")
        )
        return f"do -- {name}\n{indented}\nend -- /{name}"

    while out and not out[-1].strip():
        out.pop()
    m = re.match(r"^return\s+(\w+)\s*$", out[-1].strip())
    if not m:
        raise SystemExit(f"{name}: expected final line `return <Table>`, got: {out[-1].strip()[:60]}")
    body_out = "\n".join(out)  # keep the `return X` — it feeds the hoisted local

    indented = "\n".join(
        ("\t" + ln) if ln.strip() else ln for ln in body_out.split("\n")
    )
    return f"{name} = (function()\n{indented}\nend)() -- /{name}"


def main() -> None:
    src_dir = sys.argv[1] if len(sys.argv) > 1 else "src"
    out_file = sys.argv[2] if len(sys.argv) > 2 else "dist/VanityGeneral_INTEGRATED.lua"

    banners = [HEADER]

    # hoist all module locals first (Main is the entry chunk, no table)
    banners.append("-- Module tables (hoisted so every section can reference any module)")
    banners.append("\n".join(f"local {m}" for m in MODULES if m != "Main"))
    banners.append("")

    for mod in MODULES:
        path = f"{src_dir}/{mod}.lua"
        with open(path, encoding="utf-8") as f:
            src = f.read()
        banners.append("--" + "=" * 76)
        banners.append(f"-- {mod.upper()}")
        banners.append("--" + "=" * 76)
        banners.append(transform(mod, src))
        banners.append("")

    result = "\n".join(banners)
    with open(out_file, "w", encoding="utf-8", newline="\n") as f:
        f.write(result)
    print(f"ok: bundled {len(MODULES)} modules -> {out_file} ({len(result)} bytes)")


if __name__ == "__main__":
    main()
