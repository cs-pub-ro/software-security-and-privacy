# Exercise: cosign

**Tools:** Docker, cosign

## Goal

Verify a signed container image, then build, push and sign your own.

## Background

`cosign` signs and verifies container images.
With keyless signing, the signature is tied to an identity (an email) and an OIDC issuer (such as GitHub) rather than a long-lived key, so verification checks *who* signed, not just *that* it was signed.

## Your Task

1. Install `cosign` and verify an existing image, giving the expected `--certificate-identity` and `--certificate-oidc-issuer`.
1. Build the image here (`hello.c`, `Dockerfile`) and push it to your Docker Hub.
1. Sign your image with keyless signing, then verify it with your own identity.

## Build & Run

```console
docker build -t <your-user>/my-hello .
docker run <your-user>/my-hello
```

## Check Your Work

Verification should succeed for the correct identity and issuer, and fail if you change either.
Be ready to explain what the signature proves, and what it does not (for example, that the code is safe).
