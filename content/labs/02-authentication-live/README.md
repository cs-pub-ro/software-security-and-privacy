# Session 02: Authentication

How systems check who you are, and how that check is defeated: reading a flag off a machine you log in to, breaking a timing side channel, and cracking password hashes.

## Learning Objectives

After this session you should be able to:

* reason about where a credential check can leak information;
* mount a timing side-channel attack against a character-by-character comparison;
* crack password hashes with dictionary, rule-based and salted attacks.

## Prerequisites and Required Tools

* An SSH client.
* `python3`.
* A C++ toolchain to build the side-channel target.

Run `./scripts/check-prerequisites.sh 02` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`01-aw3som3-passw0rd`](01-aw3som3-passw0rd/) | exercise | Log in and read the flag |
| 2 | [`02-no-matter-what`](02-no-matter-what/) | exercise | Reassemble a flag split across the filesystem |
| 3 | [`03-sidechannel`](03-sidechannel/) | exercise | Guess a passphrase from timing |
| 4 | [`04-password-breaking`](04-password-breaking/) | exercise | Crack SHA-256 password hashes |

The SSH challenges are on the CTF platform, in this session's category.
