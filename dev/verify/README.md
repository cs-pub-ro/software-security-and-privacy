# Verification harness

Developer-only scripts that verify the course content by running it, entirely
in containers.
Nothing here ships to students: `dev/` is outside the archived `content/labs/*-live/`
tree, so `gen_zip.py` never packs it.

## Why containers

The only tools required on the host are **Docker** (a reachable daemon; rootless
is fine) and a POSIX shell.
Every toolchain a check needs — `gcc-multilib`, `pwntools`, `mkdocs`, Quarto,
`clang`, `cosign`, PHP, MySQL — lives inside a throwaway image, so none of it is
installed system-wide.
This is the same reason each challenge already ships `build/`, `deploy/`,
`solve/` and `publish/` Docker images; the harness only orchestrates them.

## Binary CTFs

```console
dev/verify/ctf.sh content/labs/03-exploit-app-full/01-buffer-overflow   # one challenge
dev/verify/ctf-all.sh                                                   # every binary challenge
```

For one challenge, `ctf.sh`:

1. **build** — compiles the 32-bit binary in the `build/` image (`make`).
1. **publish** — copies the artifact to `publish/`, where `deploy/` expects it.
1. **deploy** — builds the `deploy/` image with a freshly generated `--build-arg FLAG`
   and runs it on a private, per-run bridge network under the alias `deploy`.
1. **solve** — builds the `solve/` image and runs `solve/exploit.py REMOTE HOST=deploy PORT=<port>`
   against the deployment.

The **exploit is authoritative**: it asserts its own success and exits 0 when
the challenge is solved.
This works both for flag-bearing challenges — where the exploit captures the
planted `SSP{…}` and the harness double-checks that the exact planted flag came
back — and for control-flow challenges with no flag to capture (e.g.
`01-buffer-overflow`, which only has to reach three otherwise-unreachable
functions).

The port and the network are torn down on exit; pass `--keep` to leave them up
for debugging, and `--flag 'SSP{…}'` to plant a specific flag.

### What a binary challenge needs to pass

Lessons from making `01-buffer-overflow` (the model) green, which the blind port
had left broken:

* The `deploy/` image must install the **32-bit runtime** (`libc6-i386`): a bare
  `debian` image cannot `exec` a `-m32` binary and fails with
  `No such file or directory` (the missing loader).
* A networked challenge must be **unbuffered** (`setvbuf(stdout, NULL, _IONBF, 0)`
  in the source): served over a socket the C library fully buffers output, and an
  exploit that crashes the process after printing loses everything still buffered.
  (Locally it is masked, because pwntools `process()` uses a PTY, which is
  line-buffered.)

## Not yet wired up

`web.sh` (webshop / sqlinject, once ported off `mysql_*`) and `docs.sh` (mkdocs
`--strict`, Quarto render, markdownlint / shellcheck / checkpatch) are described
in the plan and will land as the corresponding content work is verified.
