# Instructor Notes: Session 06 --- Modern Solutions

All three challenges are verified.
`01-rop-shell` and `02-rop-chain` build, deploy and solve through `ctf-challenge-deployer` (`check-solution` passes against a fresh build).
`03-dop` is local (it prints a message, serves no flag): `dop` builds non-PIE with modern `clang` (`make`), `solve/exploit.py` reads `vulbuf` from the binary and makes it print `SSPPWN`, and `solve/payload.c` takes the two addresses from `nm` and makes it print `FAILAA`.

`03-dop` note: the DOP mechanic relies on `read_payload`'s `memcpy` overflowing `f`'s buffer into the adjacent loop registers, which depends on the stack layout; it is confirmed with clang 19 but is not guaranteed across every compiler, so re-run the solve if the toolchain changes.

## Deploy ports

Internal xinetd port 31337, mapped per challenge: `01-rop-shell` 10019, `02-rop-chain` 10020.
`03-dop` is local only; it prints a message rather than serving a flag.

## Shape

Run `demo-rop-demo` together: gadgets, and how a chain sits on the stack.
Then rop-shell, rop-chain, and dop as the twist (control-flow integrity is not enough).
