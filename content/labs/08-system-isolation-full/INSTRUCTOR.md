# Instructor Notes: Session 08 --- System Isolation

Local exercises, no deployment. Build verification owed.

`01-monopoly` must be run as root and only through the provided scripts; stress that, and that the escape works precisely because chroot does not drop privilege.
`02-docker` and `03-containers-vms` are hands-on tutorials; keep them exploratory.
The through-line: isolation is a spectrum (chroot < container < VM), and each level isolates more at a higher cost.
