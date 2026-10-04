# Deploy

Serves the `03-look-for-me` challenge over SSH.

The `setup` script creates the `ctf` user and plants the flag.
Both the flag and the account password are placeholders in the repository (`CTF_PASSWORD`, `SSP{placeholder}`); replace them with this deployment's real values before building, and keep the real values out of the repository.

## Build and run

```console
docker build -t 03-look-for-me-deploy .
docker run -dit --name 03-look-for-me-container -p <host-port>:22 03-look-for-me-deploy
```

## Stop

```console
docker stop 03-look-for-me-container
```
