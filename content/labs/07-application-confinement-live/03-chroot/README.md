# Exercise: chroot

**Tools:** GCC, chroot, ldd

## Goal

Use a chroot jail so the program can open `a.txt` inside the jail but cannot reach `b.txt` outside it.

## Background

`chroot` changes a process's view of the filesystem root, so paths outside the new root become unreachable.
Everything the program needs, including its shared libraries, has to be inside the jail.

## Your Task

1. Set the `A_PATH` and `B_PATH` macros in `exec.c` to full paths, and build with `make`.
1. Build a jail directory containing `exec`, `a.txt`, and the libraries from `ldd exec`.
1. Run `sudo chroot <jail> ./exec`.

## Build & Run

```console
make
sudo chroot ./jail ./exec
```

## Check Your Work

`a.txt` opens, `b.txt` does not.
Be ready to explain why the libraries had to be copied in, and what chroot does not isolate.
