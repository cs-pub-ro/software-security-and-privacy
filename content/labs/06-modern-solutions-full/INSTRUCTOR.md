# Instructor Notes: Session 06 --- Modern Solutions

`01-rop-shell` and `02-rop-chain` are verified: they build, deploy and solve through `ctf-challenge-deployer` (`check-solution` passes against a fresh build).

`03-dop` is not verified and its reference solve does not run as-is:

* `build/Makefile` pins `clang-4.0`, which is not on current systems; the source builds fine with a modern `clang`.
* `solve/exploit.py` hardcodes `vulbuf = 0x6b2090` from that old static build; a current build puts `vulbuf` elsewhere, so the address must be re-read with `nm dop` per build.
* the exploit greps its output for `SSP{...}`, but `dop` only prints `End of program: <vulbuf>` (`SISPWN`, old-course naming), so the check never matches.

Fixing `03-dop` means unpinning the compiler, deriving `vulbuf` at run time (or documenting the `nm` step), correcting the success check, and renaming `SIS`→`SSP`.

## Deploy ports

Internal xinetd port 31337, mapped per challenge: `01-rop-shell` 10019, `02-rop-chain` 10020.
`03-dop` is local only; it prints a message rather than serving a flag.

## Shape

Run `demo-rop-demo` together: gadgets, and how a chain sits on the stack.
Then rop-shell, rop-chain, and dop as the twist (control-flow integrity is not enough).
