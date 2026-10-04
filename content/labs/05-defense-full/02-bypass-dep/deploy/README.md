# Deploy

Serves `02-bypass-dep` over TCP with `xinetd`. The flag is a build argument.

```console
docker build -t 02-bypass-dep-deploy -f Dockerfile --build-arg FLAG='SSP{...}' ..
docker run -d --rm -p 31051:31337 --name 02-bypass-dep-container 02-bypass-dep-deploy
```

The public address and port are the ones on the CTF platform; they do not go in any student-facing file.
