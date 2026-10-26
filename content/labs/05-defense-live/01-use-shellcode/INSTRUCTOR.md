# Instructor notes: Use Shellcode

## Deployment

Service port: **10015** (xinetd, internal 31337).
Deployed via `ctf-challenge-deployer` as container `ssp-lab05-01_use-shellcode`.

## Key points to convey

The NOP sled compensates for the slight address variance caused by environment differences between the student's GDB session and the running process.
With ASLR off the stack base is fixed, so a large NOP sled plus a few retries is enough.

## Common mistakes

Students often forget `setarch $(uname -m) -R /bin/bash` and wonder why their local address differs every run.
The shellcode in the skeleton assumes x86 (32-bit); the binary is compiled with `-m32`.
