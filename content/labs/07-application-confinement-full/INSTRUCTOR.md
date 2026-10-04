# Instructor Notes: Session 07 --- Application Confinement

Local exercises, no deployment. Build verification owed (32-bit, libseccomp:i386, AppArmor).

The arc is one program (the task-1 shellcode opening two files) confined three ways:
AppArmor by path, chroot by filesystem view, seccomp by system call.
The teaching point is the comparison: each stops the second `open`, but for a different reason and with different holes.

The tasks reference `a.txt` and `b.txt`; each task ships its own copies so it stands alone.
The original relative paths (`../jail/`, `../../jail/`) from the previous edition may need adjusting in the carried solutions; verify when building.
