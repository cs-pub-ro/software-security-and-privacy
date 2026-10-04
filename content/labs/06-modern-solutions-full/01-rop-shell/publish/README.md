# Publish

Packages the files players receive for `01-rop-shell`.
Copy the built artifact here first:

```console
cp ../build/vuln .
docker build -t 01-rop-shell-publisher .
docker run --rm -v "$(pwd):/data" 01-rop-shell-publisher
```

This is the same set of files as the `-live/` task.
