# Instructor Notes: 01-hit-me-hard

## Deploy

Set a fresh flag and a fresh `ctf` password in `deploy/setup` (or pass them in) before building.
Verify by running `solve/extract` against the deployment and checking it prints the flag.

## Verified values

* Last verified: not re-verified against this port. Confirm before the session.

## Known issue

The `deploy/setup` carried over from the previous edition is a copy of the `reverse-kitten` setup (its header and the sudo gimmick).
`hit-me-hard` should simply leave the flag readable by the `ctf` user; rewrite `setup` accordingly before deploying.
