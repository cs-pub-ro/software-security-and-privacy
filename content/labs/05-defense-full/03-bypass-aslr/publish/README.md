# Publish

Packages the files players receive for `03-bypass-aslr`.
Copy the built artifact here first:

```console
cp ../build/vuln .
docker build -t 03-bypass-aslr-publisher .
docker run --rm -v "$(pwd):/data" 03-bypass-aslr-publisher
```

This is the same set of files as the `-live/` task.
