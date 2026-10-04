# Exercise: ROP Shell

**Tools:** GDB, ROPgadget, pwntools

## Goal

Open a shell by returning into `system("/bin/sh")`, with no injected code.

## Background

The stack is not executable, so you cannot run shellcode.
Instead you chain gadgets: short instruction sequences ending in `ret`, already in the binary.
To call `system("/bin/sh")` on x86-64 you must place the address of a `"sh"` string into `RDI`, then return into `system()`.

## Your Task

1. Build `vuln` with `make`.
1. Find the address of a `"sh"` string (for example with `find` in GDB), and a `pop rdi; ret` gadget with `ROPgadget --binary vuln`.
1. Build the ROP payload in `exploit.py`, modelled on the demo, and get a shell.

## Build & Run

```console
make
```

The deployed challenge is on the CTF platform, in this session's category.

## Check Your Work

You should get an interactive shell.
Be ready to explain each entry in your chain and why the stack is laid out the way it is.
