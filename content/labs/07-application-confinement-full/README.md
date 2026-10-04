# Session 07: Application Confinement

The reference half of the [application confinement lab](../07-application-confinement-live/README.md).

Local exercises, nothing to deploy.
Each task directory holds the reference solution: the completed shellcode, the AppArmor profile and loader scripts, the chroot `exec` and jail runner, and the seccomp-filtered `exec`.

## Tasks

| Order | Task | Mechanism |
| --- | --- | --- |
| 1 | [`01-shellcode`](01-shellcode/) | Shellcode making `open` calls |
| 2 | [`02-apparmor`](02-apparmor/) | AppArmor profile |
| 3 | [`03-chroot`](03-chroot/) | chroot jail |
| 4 | [`04-seccomp`](04-seccomp/) | seccomp syscall filter |
