# Deploy

Serves `02-rop-chain` over TCP with `xinetd`. The flag is a build argument.

```console
docker build -t 02-rop-chain-deploy -f Dockerfile --build-arg FLAG='SSP{...}' ..
docker run -d --rm -p 31061:31337 --name 02-rop-chain-container 02-rop-chain-deploy
```

The public address and port are the ones on the CTF platform; they do not go in any student-facing file.
