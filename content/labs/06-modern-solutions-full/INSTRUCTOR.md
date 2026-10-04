# Instructor Notes: Session 06 --- Modern Solutions

Build verification owed: this session was ported without a verified build/deploy/solve loop.
The reference exploits in each `solve/exploit.py` come from the previous edition and target 64-bit builds; re-check them against freshly built binaries, and set the `SSP{` prefix check and `REMOTE HOST=... PORT=...` convention.

## Deploy ports

Internal xinetd port 31337, mapped per challenge: `01-rop-shell` 31060, `02-rop-chain` 31061.
`03-dop` is local only; it prints a message rather than serving a flag.

## Shape

Run `demo-rop-demo` together: gadgets, and how a chain sits on the stack.
Then rop-shell, rop-chain, and dop as the twist (control-flow integrity is not enough).
