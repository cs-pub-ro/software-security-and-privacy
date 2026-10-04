# Exercise: Docker

**Tools:** Docker

## Goal

Build your own container image, then see how far a command-injection bug inside it can reach.

## Background

A container isolates a process with namespaces and cgroups, but a bug in the app inside it still runs with the container's view of the world.

## Your Task

1. Install Docker and run `docker run hello-world`, then `docker run -it ubuntu bash` and look around.
1. Build a custom image for a small web app (follow the Docker get-started guide).
1. Add a way to run commands from the page (for example a `GET cmd` parameter), and try to read `/etc/passwd` or break the app from outside.

## Check Your Work

Observe what the injected command can and cannot see.
Be ready to explain what the container isolated and what it did not.
