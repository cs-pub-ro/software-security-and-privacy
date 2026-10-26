# Deploy

Serves `01-use-shellcode` over TCP with `xinetd`. The flag is a build argument.

```console
docker build -t 01-use-shellcode-deploy -f Dockerfile --build-arg FLAG='SSP{...}' ..
docker run -d --rm -p 10015:31337 --name 01-use-shellcode-container 01-use-shellcode-deploy
```

The public address and port are the ones on the CTF platform; they do not go in any student-facing file.
