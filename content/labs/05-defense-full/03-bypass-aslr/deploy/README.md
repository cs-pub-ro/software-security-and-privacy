# Deploy

Serves `03-bypass-aslr` over TCP with `xinetd`. The flag is a build argument.

```console
docker build -t 03-bypass-aslr-deploy -f Dockerfile --build-arg FLAG='SSP{...}' ..
docker run -d --rm -p 31052:31337 --name 03-bypass-aslr-container 03-bypass-aslr-deploy
```

The public address and port are the ones on the CTF platform; they do not go in any student-facing file.
