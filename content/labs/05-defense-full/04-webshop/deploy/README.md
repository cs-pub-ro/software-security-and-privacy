# Deploy

Serves the webshop over HTTP with its MariaDB database, through Docker Compose.
The front end (`Dockerfile`, PHP 7.4 + `mysqli`) and the database
(`db.Dockerfile`, MariaDB) come up together on one network.

The real flag is a UNIX file `/flag` on the **database** server, reached through
the SQL injection with `LOAD_FILE`; the file served from the web root is a decoy.

Pass this deployment's real flag and database password (the committed defaults
are placeholders, rotated per deployment):

```console
FLAG='SSP{...}' DB_PASSWORD='...' docker compose up --build -d
curl 'http://localhost:8080/index.php?id=1'
```

The app reads its database host and credentials from the environment
(`DB_HOST`, `DB_USER`, `DB_PASSWORD`), wired up in `docker-compose.yml`.
The database is started with `--secure-file-priv=` so that `LOAD_FILE('/flag')`
is allowed; this is deliberate and is what the challenge exploits.

```console
docker compose down -v
```
