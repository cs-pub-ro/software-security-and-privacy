# Session 05: Defense and Mitigation

The defences that stand between a bug and a working exploit --- an executable stack, DEP, ASLR --- and how each one is bypassed when it stands alone.

## Getting the Files

Clone the repository to get the challenge source files:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/05-defense-live
```

Challenges that need local files have a Setup section pointing to the exact subdirectory.

## Learning Objectives

After this session you should be able to:

* explain what NX/DEP, ASLR and stack hardening each prevent;
* bypass a single defence: inject code when the stack is executable, defeat ASLR with a leak or brute force;
* recognise that defences are meant to be layered, because any one alone can be worked around.

## Prerequisites and Required Tools

* An x86-64 Linux machine with 32-bit support, `gdb`, `pwntools`, `checksec`.
* A web browser and `curl` for the webshop.

Run `./scripts/check-prerequisites.sh 05` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`demo-fprotect`](demo-fprotect/) | demo | What FORTIFY_SOURCE does, and does not, catch |
| 2 | [`01-use-shellcode`](01-use-shellcode/) | exercise | Inject code into an executable stack |
| 3 | [`02-bypass-dep`](02-bypass-dep/) | exercise | Defeat a non-executable stack |
| 4 | [`03-bypass-aslr`](03-bypass-aslr/) | exercise | Defeat address randomisation |
| 5 | [`04-webshop`](04-webshop/) | exercise | SQL injection to read a protected file |

The deployed challenges are on the CTF platform, in this session's category.
