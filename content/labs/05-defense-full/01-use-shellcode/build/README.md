# Build

Source and build environment for the `01-use-shellcode` challenge (32-bit x86).

```console
docker build -t 01-use-shellcode-builder .
docker run --rm -v "$(pwd):/build" 01-use-shellcode-builder make
```

Then copy the artifact to `../publish/`:

```console
cp vuln ../publish/
```
