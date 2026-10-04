# chroot

`exec.c` with full-path macros, a `Makefile`, and `run-exec-in-chroot` (which builds the jail with the binary, `a.txt` and the libraries from `ldd`, then runs it) are the reference.
chroot restricts the filesystem view only; it is not a security boundary on its own (a privileged process can escape).
See the [task](../../07-application-confinement-live/03-chroot/README.md).
