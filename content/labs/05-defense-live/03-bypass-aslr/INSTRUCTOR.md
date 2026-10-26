# Instructor notes: Bypass ASLR

## Deployment

Service port: **10017** (xinetd, internal 31337).
Deployed via `ctf-challenge-deployer` as container `ssp-lab05-03_bypass-aslr`.

## Key points to convey

The binary is compiled without PIE, so `.text` and the PLT are at fixed addresses regardless of ASLR.
`system@plt` is a stub that calls the real `system()` through the GOT; its PLT address is stable.
`"sh"` appears as a substring inside the binary itself (in a string constant), also at a fixed address.

The discussion point: enabling PIE removes both fixed anchors and forces a leak-based or brute-force approach.

## Common mistakes

Students look for `"/bin/sh"` in the binary and do not find it; `"sh"` is the shorter string that also works with `system()`.
