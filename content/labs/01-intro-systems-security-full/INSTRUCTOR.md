# Instructor Notes: Session 01 --- Introduction to Systems Security

The first session: tone-setting, not difficulty. Everyone should capture every flag.

## Before the session

Deploy the four SSH challenges, each with a fresh flag and a fresh `ctf` password set in its `deploy/setup`.
Verify each one with its `solve/extract`.
See the known issue in `01-hit-me-hard/INSTRUCTOR.md`: its carried `setup` is a copy of `reverse-kitten`'s and must be rewritten to simply leave the flag readable.

## Deploy secrets

The flags and passwords in the repository are placeholders.
Keep the real per-deployment values out of the repository; they belong in the internal repository (see `dev/internal-residue.md`).

## Shape of the session

`demo-checksec` together first: it introduces the defences the whole course is about.
Then the four recon challenges, in order of how much they ask: read it, find it, recover it, borrow privilege for it.

## Teardown

Stop every container after the session unless it is kept up for take-home work.
