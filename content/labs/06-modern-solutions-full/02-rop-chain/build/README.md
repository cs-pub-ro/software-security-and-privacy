# Build

Source and build environment for the `02-rop-chain` challenge (64-bit x86).

```console
docker build -t 02-rop-chain-builder .
docker run --rm -v "$(pwd):/build" 02-rop-chain-builder make
```

Then copy the artifact to `../publish/`:

```console
cp vuln ../publish/
```
