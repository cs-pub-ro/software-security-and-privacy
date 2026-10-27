# Exercise: Bypass DEP

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/05-defense-live/02-bypass-dep
```

If you already cloned the repository for this lab, just `cd` into the directory above.
The challenge binary `vuln` is in this directory, together with `libc.so.6` — the exact C library the remote service runs.
A return-to-libc exploit needs the addresses of `system()` and `/bin/sh` inside *that* library, so compute your offsets from this `libc.so.6`, not from your own system's.

**Tools:** GDB, pwntools

## Goal

Get a shell on a binary whose stack is *not* executable (DEP/NX enabled).

## Background

With DEP, bytes on the stack cannot be executed, so injected shellcode is stopped.
The buffer overflow still lets you redirect execution, but you have to reuse code that is already in the process — this is a return-to-libc attack.
The environment has ASLR disabled, so library addresses are fixed.

## Your Task

1. Confirm DEP is on: `checksec vuln`.
1. Find the overflow offset and identify a useful gadget (e.g. `system()`).
   Read the offsets of `system()` and the string `/bin/sh` (or `sh`) from the provided `libc.so.6`, and add them to the libc base you leak at run time.
1. Craft a payload in `exploit.py` that overwrites the return address of `reader()` to call `system("/bin/sh")`.
1. Connect to the service listed on the CTF platform and run `exploit.py`.

## Check Your Work

You should get a shell without executing any stack data.
Be ready to explain why DEP alone did not stop you.
