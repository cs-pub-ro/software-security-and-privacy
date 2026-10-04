# aw3som3-passw0rd

## Goal

Recover the flag from the deployed SSH challenge; see the [task](../../02-authentication-live/01-aw3som3-passw0rd/README.md) for the statement.

## Solution

The reference script is in [`solve/`](solve/); it logs in and recovers the flag.
Adapt the host, port and password to the deployment.

## Deploy

[`deploy/`](deploy/) builds an sshd image and runs `setup` to create the `ctf` account and plant the flag; both are placeholders set per deployment.
