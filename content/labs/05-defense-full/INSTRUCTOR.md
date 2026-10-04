# Instructor Notes: Session 05 --- Defense and Mitigation

Build verification owed: ported without a verified build/deploy/solve loop.

## Binary challenges

32-bit; deploy ports: `01-use-shellcode` 31050, `02-bypass-dep` 31051, `03-bypass-aslr` 31052 (internal xinetd 31337).
The reference exploits come from the previous edition; `use-shellcode` needs a per-machine stack address tuned in `exploit.py`, and `bypass-aslr` relies on brute force, so both can be slow. Re-verify against fresh builds.

## Webshop

Web challenge; the real flag is the UNIX file `/flag`, reached through the SQL injection (the web-root `flag` is a decoy).
The app targets the removed `mysql_*` PHP API; see `04-webshop/deploy/README.md` for the port-or-pin-PHP5 decision before deploying.
The DB password in the app is a placeholder.

## Deploy secrets

Flags and the DB password are placeholders in the repository; real values belong in the internal repository (`dev/internal-residue.md`).
