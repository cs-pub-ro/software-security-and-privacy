# Instructor notes: Bypass DEP

## Deployment

Service port: **3502** (xinetd, internal 31337).
Deployed via `ctf-challenge-deployer` as container `ssp-lab05-02_bypass-dep`.

## Key points to convey

The return-to-libc chain is: padding → address of `system()` → fake return address → address of `"/bin/sh"`.
The fake return address is 4 bytes of padding here since we do not care where `system()` returns.
ASLR is off so `system()` and `"/bin/sh"` are at fixed addresses; have students confirm with `ldd vuln` across multiple runs.

## Common mistakes

Students mix up 32-bit calling convention (args on the stack) with 64-bit (args in registers).
The binary is 32-bit; `system()` takes its argument from the stack, not from `rdi`.
