# Publish

Packages the files players receive for `01-use-shellcode`.
Copy the built artifact here first:

```console
cp ../build/vuln .
docker build -t 01-use-shellcode-publisher .
docker run --rm -v "$(pwd):/data" 01-use-shellcode-publisher
```

This is the same set of files as the `-live/` task.
