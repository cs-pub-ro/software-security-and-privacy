# Session 07: Application Confinement

Keeping a program from doing more than it should, even when it is compromised: shellcode that opens files, then AppArmor, chroot and seccomp each stopping some of those opens.

## Learning Objectives

After this session you should be able to:

* write shellcode that makes system calls such as `open`;
* confine a program with an AppArmor profile, a chroot jail, and a seccomp filter;
* explain what each mechanism can and cannot restrict.

## Prerequisites and Required Tools

* An x86-64 Linux machine with 32-bit support, `nasm`, `strace`.
* `apparmor` utilities (task 2) and `libseccomp-dev:i386` (task 4).

Run `./scripts/check-prerequisites.sh 07` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`01-shellcode`](01-shellcode/) | exercise | Shellcode that opens two files |
| 2 | [`02-apparmor`](02-apparmor/) | exercise | Allow one file, deny the other with AppArmor |
| 3 | [`03-chroot`](03-chroot/) | exercise | Confine file access with a chroot jail |
| 4 | [`04-seccomp`](04-seccomp/) | exercise | Restrict system calls with seccomp |

These are local exercises; there is nothing to submit to the platform.
