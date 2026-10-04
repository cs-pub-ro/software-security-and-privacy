# Exercise: seccomp

**Tools:** GCC, libseccomp, strace

## Goal

Use a seccomp filter so the program may read and write `a.txt`, but only read `b.txt`.

## Background

seccomp filters the system calls a process may make, by number and arguments.
Unlike AppArmor and chroot, it works at the system-call boundary rather than on paths.

## Your Task

1. Read `exec.c`, build with `make`, and run `strace ./exec` to see the calls it makes.
1. Extend `exec.c` to install a seccomp filter that allows read and write on the `a.txt` descriptor but only read on `b.txt`.

## Build & Run

```console
make
strace ./exec
```

## Check Your Work

Writes to `b.txt` should be blocked while reads succeed.
Be ready to compare seccomp's syscall-level control with AppArmor's path-level control.
