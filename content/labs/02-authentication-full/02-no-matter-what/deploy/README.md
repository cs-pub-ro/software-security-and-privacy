# Deploy

Serves the `02-no-matter-what` challenge over SSH.

The `setup` script creates the `ctf` user and plants the flag.
Both the flag and the account password are placeholders in the repository (`CTF_PASSWORD`, `SSP{placeholder}`); replace them with this deployment's real values before building, and keep the real values out of the repository.

## Build and run

```console
docker build -t 02-no-matter-what-deploy .
docker run -dit --name 02-no-matter-what-container -p <host-port>:22 02-no-matter-what-deploy
```

## Stop

```console
docker stop 02-no-matter-what-container
```
