# Solve

Reference exploit and a containerised solver for `01-rop-shell`.
`exploit.py` is carried over from the previous edition; verify it before a session (it should check for the `SSP{` prefix and use `REMOTE HOST=... PORT=...`).

```console
docker build -t 01-rop-shell-solver .
docker run --rm -it --network host -v "$(pwd):/solve" 01-rop-shell-solver \
    python3 /solve/exploit.py REMOTE HOST=127.0.0.1 PORT=31060
```
