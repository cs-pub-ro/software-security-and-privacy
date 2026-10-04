# Build

Source and build environment for the `01-rop-shell` challenge (64-bit x86).

```console
docker build -t 01-rop-shell-builder .
docker run --rm -v "$(pwd):/build" 01-rop-shell-builder make
```

Then copy the artifact to `../publish/`:

```console
cp vuln ../publish/
```
