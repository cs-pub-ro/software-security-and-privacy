# cosign

## Goal

Verify and sign container images with cosign.

## Solution

`hello.c`, `Dockerfile` and `Makefile.docker` build a minimal image.
Verification with `cosign verify <image> --certificate-identity=<email> --certificate-oidc-issuer=<issuer>` succeeds only when both match the signer; keyless signing binds the signature to that identity through an OIDC flow rather than a stored key.
The signature attests provenance (who built and signed it), not that the contents are benign.
See the [task](../../10-supply-chain-security-live/01-cosign/README.md).
