# seccomp

`exec.c` with the seccomp filter (read+write on `a.txt`, read-only on `b.txt`) is the reference.
seccomp filters at the system-call boundary, so it restricts actions regardless of path, but it cannot express path-based policy the way AppArmor does.
See the [task](../../07-application-confinement-live/04-seccomp/README.md).
