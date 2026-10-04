# ROP Chain

## Goal

Call `mega_checker()` with `RDI` and `RSI` set through gadgets, so both messages print.

## Solution

Chain a `pop rdi; ret` and a `pop rsi; ...; ret` gadget to load the two arguments, then return into `mega_checker()` after `checker()`.
`solve/exploit.py` is the reference.
See the [task](../../06-modern-solutions-live/02-rop-chain/README.md).
