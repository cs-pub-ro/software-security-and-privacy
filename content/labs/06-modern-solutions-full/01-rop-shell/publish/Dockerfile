FROM alpine:latest
RUN apk add --no-cache zip
WORKDIR /data
CMD ["zip", "-r", "01-rop-shell.zip", ".", "-x", "Dockerfile", "-x", "README.md"]
