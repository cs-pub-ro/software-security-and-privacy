# Deploy

Serves the webshop over HTTP, with the flag in `/flag` on the server.

The database password in the app is a placeholder (`CTF_DB_PASSWORD`); set it, and a matching database, for the deployment.
The flag is a build argument.

```console
docker build -t webshop-deploy --build-arg FLAG='SSP{...}' .
docker run -d --rm -p 8080:80 --name webshop-container webshop-deploy
```

The database (`schema.sql`) must be loaded into a MySQL/MariaDB reachable by the app; wire it up with a second container or a compose file.

## Build verification owed

The original app uses the removed `mysql_*` PHP API and a `php5` runtime.
Either base the image on `php:5`, or port the app to `mysqli` (the connection in `index.php`), before this deploys.
