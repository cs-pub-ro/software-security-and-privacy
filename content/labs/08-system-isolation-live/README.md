# Session 08: System Isolation

The boundaries that separate workloads from each other and from the host --- chroot jails, containers and virtual machines --- and what it takes to break out of, or recover from, each.

## Learning Objectives

After this session you should be able to:

* escape a chroot jail you entered as root, and explain why chroot is not a security boundary;
* build a container image and reason about what a command-injection bug inside it can reach;
* place containers and virtual machines on the isolation spectrum, and recover a broken VM from a snapshot.

## Prerequisites and Required Tools

* A Linux machine with root, Docker, and a virtualization product for the VM task.

Run `./scripts/check-prerequisites.sh 08` to check.

## Tasks

| Order | Task | Type | Objective |
| --- | --- | --- | --- |
| 1 | [`01-monopoly`](01-monopoly/) | exercise | Escape a chroot jail as root |
| 2 | [`02-docker`](02-docker/) | exercise | Build a container and probe its isolation |
| 3 | [`03-containers-vms`](03-containers-vms/) | exercise | Containers, VMs and snapshots |

These are local exercises; there is nothing to submit to the platform.
