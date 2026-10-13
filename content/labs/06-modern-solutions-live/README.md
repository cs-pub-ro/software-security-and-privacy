# Session 06: Modern Offensive and Defensive Solutions

When the stack is not executable, exploitation moves to reusing the program's own code: return-oriented programming (ROP) and data-oriented programming (DOP), and the defences aimed at them.

## Getting the Files

Clone the repository to get the challenge source files:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/06-modern-solutions-live
```

Challenges that need local files have a Setup section pointing to the exact subdirectory.

## Learning Objectives

After this session you should be able to:

* chain existing instruction sequences (gadgets) into a ROP payload that calls a function of your choosing;
* set up argument registers through gadgets to call a function with arguments;
* understand data-oriented programming, and why control-flow defences do not stop it.

## Prerequisites and Required Tools

* An x86-64 Linux machine, `gdb`, `ROPgadget`, `pwntools`.
* `clang`/LLVM for the DOP task's SafeStack build.

Run `./scripts/check-prerequisites.sh 06` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`demo-rop-demo`](demo-rop-demo/) | demo | A first ROP payload, worked together |
| 2 | [`01-rop-shell`](01-rop-shell/) | exercise | ROP into `system("/bin/sh")` |
| 3 | [`02-rop-chain`](02-rop-chain/) | exercise | Chain gadgets to call a function with two arguments |
| 4 | [`03-dop`](03-dop/) | exercise | Data-oriented programming, and SafeStack |

The networked challenges are on the CTF platform, in this session's category.
