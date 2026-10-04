# Build

Source and build environment for the `03-bypass-aslr` challenge (32-bit x86).

```console
docker build -t 03-bypass-aslr-builder .
docker run --rm -v "$(pwd):/build" 03-bypass-aslr-builder make
```

Then copy the artifact to `../publish/`:

```console
cp vuln ../publish/
```
