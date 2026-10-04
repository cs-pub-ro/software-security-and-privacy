# ROP Shell

## Goal

Return into `system("/bin/sh")` via a ROP chain.

## Solution

Place the address of a `"sh"` string into `RDI` with a `pop rdi; ret` gadget, then return into `system()`.
`solve/exploit.py` is the reference; `build/` compiles the binary and `deploy/` serves it.
See the [task](../../06-modern-solutions-live/01-rop-shell/README.md).
