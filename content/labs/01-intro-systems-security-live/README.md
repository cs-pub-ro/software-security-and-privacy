# Session 01: Introduction to Systems Security

A first contact with the tools and the mindset of the class: inspect a binary's defences, and get onto a remote machine to recover a flag it was not meant to give up.

## Learning Objectives

After this session you should be able to:

* read the security properties of an executable with `checksec`, and set them with GCC options;
* connect to a challenge over SSH and move around an unfamiliar filesystem;
* recover a file you are not meant to read, by going around the restriction rather than through it.

## Prerequisites and Required Tools

* `gcc` and `checksec` (or `pwn checksec`).
* An SSH client, and `sshpass` or `expect` for scripting a login.
* `tar`, `find` and the usual shell tools.

Run `./scripts/check-prerequisites.sh 01` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`demo-checksec`](demo-checksec/) | demo | Read and set a binary's defences |
| 2 | [`01-hit-me-hard`](01-hit-me-hard/) | exercise | Read a flag that is there for the taking |
| 3 | [`02-cant-find-me`](02-cant-find-me/) | exercise | Find where a flag is hidden on the filesystem |
| 4 | [`03-look-for-me`](03-look-for-me/) | exercise | Recover a flag from a readable backup |
| 5 | [`04-reverse-kitten`](04-reverse-kitten/) | exercise | Read a flag you have no permission to read |

The challenges are on the CTF platform, in this session's category; connect to the address listed there and submit the flag on the platform.
