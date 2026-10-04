FROM alpine:latest
RUN apk add --no-cache zip
WORKDIR /data
CMD ["zip", "-r", "02-bypass-dep.zip", ".", "-x", "Dockerfile", "-x", "README.md"]
