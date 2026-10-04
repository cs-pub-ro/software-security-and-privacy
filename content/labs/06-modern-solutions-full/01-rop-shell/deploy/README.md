# Deploy

Serves `01-rop-shell` over TCP with `xinetd`. The flag is a build argument.

```console
docker build -t 01-rop-shell-deploy -f Dockerfile --build-arg FLAG='SSP{...}' ..
docker run -d --rm -p 31060:31337 --name 01-rop-shell-container 01-rop-shell-deploy
```

The public address and port are the ones on the CTF platform; they do not go in any student-facing file.
