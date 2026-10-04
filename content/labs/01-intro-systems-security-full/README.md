# Session 01: Introduction to Systems Security

The reference half of the [introduction lab](../01-intro-systems-security-live/README.md): how each flag is recovered, and the files that deploy each challenge.

The four recon challenges are served over SSH.
Each challenge directory has:

* `README.md` --- the solution.
* `deploy/` --- a Docker image running `sshd`, with a `setup` script that creates the `ctf` account and plants the flag the way the challenge needs.
* `solve/` --- a script that logs in and recovers the flag.
* `flag` --- a placeholder; the real flag and the account password are set at deploy time.

`demo-checksec` is a local build exercise, with no deployment.

## Tasks

| Order | Task | Technique |
| --- | --- | --- |
| 1 | [`demo-checksec`](demo-checksec/) | Reading and setting binary defences |
| 2 | [`01-hit-me-hard`](01-hit-me-hard/) | Plain access |
| 3 | [`02-cant-find-me`](02-cant-find-me/) | Filesystem search |
| 4 | [`03-look-for-me`](03-look-for-me/) | Recover from a readable backup |
| 5 | [`04-reverse-kitten`](04-reverse-kitten/) | Privilege via `sudo` |
