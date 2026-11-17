# Exercise: Shellcode

## Setup

Clone the repository and change into this challenge's directory:

```console
git clone https://github.com/cs-pub-ro/software-security-and-privacy.git
cd software-security-and-privacy/content/labs/07-application-confinement-live/01-shellcode
```

If you already cloned the repository for this lab, just `cd` into the directory above.

**Tools:** nasm, GCC, strace

## Goal

Extend a shellcode so that, besides its original action, it opens two files with the `open` system call.

## Background

`generate-shellcode/` assembles `shellcode.asm` into a raw blob (`make print`); the blob is pasted into the `shellcode` array in `run-shellcode/`'s `exec.c` and executed.
The two files to open are `a.txt` and `b.txt`.

## Your Task

1. In `generate-shellcode/`, see what the shellcode does (`make print`, then `strace ./exec` in that directory).
1. Add `open("a.txt", O_RDONLY)` and `open("b.txt", O_RDONLY)` to `shellcode.asm` (first argument in `ebx`, second in `ecx`; `O_RDONLY` from `/usr/include/bits/fcntl-linux.h`).
1. Regenerate with `make print`, paste it into `run-shellcode/exec.c`, rebuild, and confirm with `strace ./vuln`.

## Build & Run

```console
make -C generate-shellcode print
make -C run-shellcode
```

## Check Your Work

`strace` should show both `open` calls.
This is the program the next three tasks confine.
