# Deploy

Serves the `04-reverse-kitten` challenge over SSH.

The `setup` script creates the `ctf` user and plants the flag.
Both the flag and the account password are placeholders in the repository (`CTF_PASSWORD`, `SSP{placeholder}`); replace them with this deployment's real values before building, and keep the real values out of the repository.

## Build and run

```console
docker build -t 04-reverse-kitten-deploy .
docker run -dit --name 04-reverse-kitten-container -p <host-port>:22 04-reverse-kitten-deploy
```

## Stop

```console
docker stop 04-reverse-kitten-container
```
