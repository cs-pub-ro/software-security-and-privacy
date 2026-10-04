FROM alpine:latest
RUN apk add --no-cache zip
WORKDIR /data
CMD ["zip", "-r", "03-bypass-aslr.zip", ".", "-x", "Dockerfile", "-x", "README.md"]
