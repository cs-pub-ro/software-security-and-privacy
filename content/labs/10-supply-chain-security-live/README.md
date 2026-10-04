# Session 10: Software Supply Chain Security

Trusting what you ship and what you depend on: signing container images and verifying signatures, so a consumer can tell a genuine artifact from a tampered one.

## Learning Objectives

After this session you should be able to:

* verify a signed container image with `cosign`, checking identity and issuer;
* build, push and sign your own image using keyless signing;
* explain what a signature does and does not guarantee about a supply chain.

## Prerequisites and Required Tools

* Docker and a Docker Hub account.
* `cosign`.

Run `./scripts/check-prerequisites.sh 10` to check.

## Tasks

| Order | Task | Objective |
| --- | --- | --- |
| 1 | [`01-cosign`](01-cosign/) | Verify and sign container images |

This is a hands-on tutorial; there is nothing to submit to the platform.
