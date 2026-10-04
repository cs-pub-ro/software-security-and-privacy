# Docker

## Goal

Build a container and probe what a command-injection bug inside it reaches.

## Solution

`app.py`, `Dockerfile` and `requirements.txt` are a reference image with a deliberate command-execution endpoint.
Injected commands run inside the container's namespaces: they see the container's `/etc/passwd`, not the host's, which is the isolation at work --- and its limit, since a container escape or a shared mount would change that.
See the [task](../../08-system-isolation-live/02-docker/README.md).
