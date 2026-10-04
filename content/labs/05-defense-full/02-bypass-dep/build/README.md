# Build

Source and build environment for the `02-bypass-dep` challenge (32-bit x86).

```console
docker build -t 02-bypass-dep-builder .
docker run --rm -v "$(pwd):/build" 02-bypass-dep-builder make
```

Then copy the artifact to `../publish/`:

```console
cp vuln ../publish/
```
