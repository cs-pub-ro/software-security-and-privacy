# Exercise: Bypass DEP

**Tools:** GDB, pwntools

## Goal

Get a shell on a binary whose stack is *not* executable (DEP/NX enabled).

## Background

With DEP, bytes on the stack cannot be executed, so injected shellcode is stopped.
The buffer overflow still lets you redirect execution, but you have to reuse code that is already in the process — this is a return-to-libc attack.
The environment has ASLR disabled, so library addresses are fixed.

## Your Task

1. Download the binary from the archive.
1. Confirm DEP is on: `checksec vuln`.
1. Find the overflow offset and identify a useful gadget (e.g. `system()`).
   In GDB, look up the address of `system()` and the string `/bin/sh` (or `sh`) in libc.
1. Craft a payload in `exploit.py` that overwrites the return address of `reader()` to call `system("/bin/sh")`.
1. Connect to the service listed on the CTF platform and run `exploit.py`.

## Check Your Work

You should get a shell without executing any stack data.
Be ready to explain why DEP alone did not stop you.
