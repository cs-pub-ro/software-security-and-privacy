# Exercise: Bypass ASLR

**Tools:** GDB, pwntools

## Goal

Exploit a binary with address-space randomisation enabled.

## Background

ASLR randomises where the stack and libraries land, so hardcoded addresses fail.
There are two ways through: leak an address at run time and compute the rest from it, or brute-force a small amount of entropy by retrying.

## Your Task

1. Build `vuln` with `make`.
1. Decide whether a leak or brute force fits this binary.
1. Complete `exploit.py` to get a shell with ASLR on.

## Build & Run

```console
make
python3 exploit.py
```

## Check Your Work

You should get a shell with randomisation enabled.
Be ready to explain how you obtained a valid address despite ASLR.
