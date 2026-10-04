# Monopoly

## Goal

Escape a root chroot jail and read the real `/flag`.

## Solution

A root process can call `chroot` on a directory below the current root and then `chdir` upward with `..` past it, because chroot only moves the root pointer and does not restrict a privileged process from moving it again.
`umount.c` is the reference escape; `go_to_jail` and `destroy_jail` set up and tear down the jail.
The lesson: chroot is a filesystem-view tool, not a privilege boundary; containers add namespaces and dropped capabilities for that.
See the [task](../../08-system-isolation-live/01-monopoly/README.md).
