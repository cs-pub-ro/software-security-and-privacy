# Exercise: Bypass ASLR

**Tools:** GDB, pwntools

## Goal

Exploit a binary with both DEP and ASLR enabled.

## Background

With ASLR on, library addresses are randomised at each run, so hardcoded addresses fail.
However, the binary itself is not position-independent (PIE is off), so its own code segment is at a fixed address.
`system()` has an entry in the PLT at a known, stable address; the string `sh` appears inside the binary itself.
A return-to-PLT attack uses these fixed-address gadgets instead of libc directly.

## Your Task

1. Download the binary from the archive.
1. Confirm the protections: `checksec vuln`.
1. In GDB, locate the PLT entry for `system` and the `sh` string inside the binary.
1. Craft a payload in `exploit.py` that calls `system@plt("sh")` by overwriting the return address.
1. Connect to the service listed on the CTF platform and run `exploit.py`.

## Check Your Work

You should get a shell with randomisation enabled.
Be ready to explain why PLT addresses are stable even when ASLR is on, and what happens when PIE is also enabled.
