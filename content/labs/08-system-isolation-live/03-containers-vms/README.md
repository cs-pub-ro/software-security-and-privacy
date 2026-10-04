# Exercise: Containers and Virtual Machines

**Tools:** a virtualization product, LXC

## Goal

Compare container and virtual-machine isolation, and recover a VM from a snapshot.

## Background

Containers share the host kernel; virtual machines run their own.
A snapshot captures a VM's whole state, which is what makes recovery from a destructive change possible.

## Your Task

1. Create an Ubuntu VM in your virtualization product.
1. Inside it, create an LXC container and experiment with the `lxc-*` commands.
1. Take a snapshot of the VM.
1. **Only inside the VM**, break it (for example overwrite the disk), then restore it from the snapshot.

## Check Your Work

You should recover the VM to its pre-break state.
Be ready to explain what a snapshot captures, and why you would never run the destructive step outside the VM.
