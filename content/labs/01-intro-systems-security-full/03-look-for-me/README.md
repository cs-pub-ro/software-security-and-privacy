# look-for-me

## Goal

Recover the flag from the deployed SSH challenge; see the [task](../../01-intro-systems-security-live/03-look-for-me/README.md) for the player-facing statement.

## Solution

The reference login-and-extract script is in [`solve/extract`](solve/).
It connects as the `ctf` user (with `sshpass` or `expect`) and recovers the flag; adapt the host, port and password to the deployment.

## Deploy

[`deploy/`](deploy/) builds an `sshd` image and runs `setup` to create the `ctf` account and plant the flag.
The flag and the account password are placeholders in the repository and are set per deployment; see [`deploy/README.md`](deploy/README.md).
