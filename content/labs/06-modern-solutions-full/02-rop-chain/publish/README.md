# Publish

Packages the files players receive for `02-rop-chain`.
Copy the built artifact here first:

```console
cp ../build/vuln .
docker build -t 02-rop-chain-publisher .
docker run --rm -v "$(pwd):/data" 02-rop-chain-publisher
```

This is the same set of files as the `-live/` task.
