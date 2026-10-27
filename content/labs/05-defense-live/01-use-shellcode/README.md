# Exercise: Use Shellcode

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/05-defense-live/01-use-shellcode
```

If you already cloned the repository for this lab, just `cd` into the directory above.
The challenge binary `vuln` is in this directory, alongside its source `vuln.c`.

**Tools:** GDB, pwntools

## Goal

Inject and run shellcode on a binary whose stack is executable, in a non-ASLR environment.

## Background

`vuln` is built with `-zexecstack`, so bytes pushed onto the stack can be executed as code.
The exploit crafts a shellcode payload, injects it into the buffer, and overwrites the return address to point back into the buffer.
Because the buffer's exact address shifts with the environment, the exploit pads with NOP instructions and retries over a range of addresses until one lands in the sled.

This task comes pre-solved: the point is to understand the technique and tune the address to the remote service.

## Your Task

1. Disassemble the provided `vuln` — find the overflow and the offset to the return address.
1. Disable ASLR locally: `setarch $(uname -m) -R /bin/bash`.
1. In GDB, break at `reader` and read `$esp` after the prologue to get the approximate buffer address.
1. Update the guess address in `exploit.py`.
1. Connect to the service listed on the CTF platform and run `exploit.py`.

## Check Your Work

You should get a shell after a short retry loop.
Be ready to explain why the NOP sled is needed even when ASLR is off.
