# Deploy

Serves the `01-aw3som3-passw0rd` challenge over SSH.

The `setup` script creates the `ctf` user and plants the flag.
Both the flag and the account password are placeholders in the repository (`CTF_PASSWORD`, `SSP{placeholder}`); replace them with this deployment's real values before building, and keep the real values out of the repository.

## Build and run

```console
docker build -t 01-aw3som3-passw0rd-deploy .
docker run -dit --name 01-aw3som3-passw0rd-container -p <host-port>:22 01-aw3som3-passw0rd-deploy
```

## Stop

```console
docker stop 01-aw3som3-passw0rd-container
```
