# ROP demo

## Goal

Show a first return-oriented payload end to end, as the template for the exercises.

## Solution

`vuln.c` overflows into the saved return address; with the stack non-executable, the payload is a chain of gadgets.
`exploit.py` is the worked reference: find gadgets with `ROPgadget`, place them and their data on the stack, and return through them.
