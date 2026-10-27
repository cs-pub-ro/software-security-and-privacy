# Deploy

Serves the webshop over HTTP from one container that runs both Apache/PHP and MariaDB (`Dockerfile`, `start.sh`).

The real flag is the UNIX file `/flag`, reached through the SQL injection with `LOAD_FILE`; the file served from the web root is a decoy.
`mariadb.cnf` sets `secure_file_priv=` so that `LOAD_FILE('/flag')` is allowed; this is deliberate and is what the challenge exploits.

Pass this deployment's real flag and database password (the committed defaults are placeholders, rotated per deployment):

```console
docker build -f deploy/Dockerfile --build-arg FLAG_VALUES='SSP{...}' --build-arg DB_PASSWORD='...' -t 04-webshop-deploy .
docker run -d --rm -p 10018:80 --name 04-webshop-container 04-webshop-deploy
curl 'http://localhost:10018/index.php?id=1'
```

Run both commands from the challenge directory, which is the build context.
`ssp-deploy.py` deploys it as `ssp-lab05-04_webshop` on host port 10018.

```console
docker stop 04-webshop-container
```
