# Solve

Reference exploit and a containerised solver for `02-bypass-dep`.
`exploit.py` is carried over from the previous edition; verify it before a session (it should check for the `SSP{` prefix).

## Build the solver image

```console
docker build -t 02-bypass-dep-solver .
```

## Local solve

Run the exploit against a local binary process (no deployment needed):

```console
docker run --rm -it \
    -v "$(pwd):/solve" -v "$(pwd)/../publish:/publish" -w /publish \
    02-bypass-dep-solver python3 /solve/exploit.py
```

## Against a deployment

`ssp-deploy.py check-solution` handles this automatically.
To run manually, mount the binary so `ELF("./vuln")` and `ELF("./libc.so.6")` resolve
(both are called at module load; `libc.so.6` is shipped in `publish/`):

```console
docker run --rm -it --network host \
    -v "$(pwd):/solve" -v "$(pwd)/../publish:/publish" -w /publish \
    02-bypass-dep-solver python3 /solve/exploit.py --host 127.0.0.1 --port 31051
```
