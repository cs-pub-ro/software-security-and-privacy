# checksec

## Goal

Read the security properties of an executable, and set them with GCC options.

## Background

`checksec` reports whether a binary has NX, a stack canary, PIE and RELRO.
These are the defences the course works with throughout: NX (session 03's shellcode needs it off, and ret-to-libc exists because of it), the canary and PIE (session 05), RELRO (the GOT, session 06).

## Build & Run

```console
make
make test            # runs checksec on both
```

The `Makefile` builds the same `hello.c` twice: `all_hardening` (`-fstack-protector-all -pie -Wl,-z,relro,-z,now`) and `no_hardening` (`-fno-stack-protector -no-pie -zexecstack`).

## Results and Explanations

`make test` runs `checksec` on both: the hardened binary reports a canary, NX, PIE and full RELRO; the weak one reports none of these, and an RWX segment.
Line the two `checksec` outputs up side by side and name what changed.
