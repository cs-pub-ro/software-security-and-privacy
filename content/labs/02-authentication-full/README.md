# Session 02: Authentication

The reference half of the [authentication lab](../02-authentication-live/README.md).

Two challenges are served over SSH (`01-aw3som3-passw0rd`, `02-no-matter-what`), each with a `deploy/` sshd image and a carried `solve/` script; their flags and passwords are placeholders set at deploy time.
Two are local exercises (`03-sidechannel`, `04-password-breaking`) with the completed solution scripts.

## Tasks

| Order | Task | Technique |
| --- | --- | --- |
| 1 | [`01-aw3som3-passw0rd`](01-aw3som3-passw0rd/) | SSH login |
| 2 | [`02-no-matter-what`](02-no-matter-what/) | Reassembly by timestamp |
| 3 | [`03-sidechannel`](03-sidechannel/) | Timing side channel |
| 4 | [`04-password-breaking`](04-password-breaking/) | Hash cracking |
