# Exercise: Use Shellcode

**Tools:** GDB, pwntools

## Goal

Inject and run shellcode on a binary whose stack is executable, in a non-ASLR environment.

## Background

`vuln` is built with `-zexecstack`, so bytes on the stack can be executed.
This task is already solved: the point is to understand the exploit and tune one address to your machine.
Because the buffer's address shifts with the environment, the exploit pads with NOPs and retries a range of addresses.

## Your Task

1. Disassemble `vuln`, find the overflow and the offset to the return address.
1. Start a non-ASLR shell: `setarch $(uname -m) -R /bin/bash`.
1. In GDB, read the approximate buffer address (`$esp` after the `reader` prologue), and update the guess address in `exploit.py`.
1. Run `exploit.py` and let the NOP-sled randomisation land a hit.

## Build & Run

```console
make
python3 exploit.py
```

## Check Your Work

You should get a shell after a short retry loop.
Be ready to explain why the NOP sled is needed even with ASLR off.
