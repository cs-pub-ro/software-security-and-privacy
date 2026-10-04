# Exercise: Bypass DEP

**Tools:** GDB, pwntools

## Goal

Get a shell on a binary whose stack is *not* executable.

## Background

With DEP/NX, injected shellcode will not run.
The overflow still lets you redirect execution, so you reuse existing code instead (as in the return-to-libc and ROP exercises).

## Your Task

1. Build `vuln` with `make` and confirm with `checksec` that the stack is non-executable.
1. Find the offset and the code to reuse to spawn a shell.
1. Complete `exploit.py`.

## Build & Run

```console
make
python3 exploit.py
```

## Check Your Work

You should get a shell without executing any stack data.
Be ready to explain why DEP alone did not stop you.
