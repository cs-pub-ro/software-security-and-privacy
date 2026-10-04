# Publish

Packages the files players receive for `02-bypass-dep`.
Copy the built artifact here first:

```console
cp ../build/vuln .
docker build -t 02-bypass-dep-publisher .
docker run --rm -v "$(pwd):/data" 02-bypass-dep-publisher
```

This is the same set of files as the `-live/` task.
