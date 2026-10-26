# Solve

Reference exploit and a containerised solver for `02-rop-chain`.
`exploit.py` is carried over from the previous edition; verify it before a session (it should check for the `SSP{` prefix).

## Build the solver image

```console
docker build -t 02-rop-chain-solver .
```

## Local solve

Run the exploit against a local binary process (no deployment needed):

```console
docker run --rm -it \
    -v "$(pwd):/solve" -v "$(pwd)/../publish:/publish" -w /publish \
    02-rop-chain-solver python3 /solve/exploit.py
```

## Against a deployment

`ssp-deploy.py check-solution` handles this automatically.
To run manually, mount the binary so `ELF("./vuln")` resolves (it is called at module load):

```console
docker run --rm -it --network host \
    -v "$(pwd):/solve" -v "$(pwd)/../publish:/publish" -w /publish \
    02-rop-chain-solver python3 /solve/exploit.py --host 127.0.0.1 --port 10020
```
