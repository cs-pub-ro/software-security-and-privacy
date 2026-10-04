# build: docker build -t sis-01_reverse-kitten .
# run: docker run -dit --name sis-01_reverse-kitten -p CTF_PORT:22 sis-01_reverse-kitten
# stop: docker stop sis-01_reverse-kitten
FROM debian:11

RUN apt-get -y update; apt-get -y install ssh vim nano sudo; apt-get -y update --fix-missing

COPY flag setup /
RUN /setup; rm /flag /setup

ENTRYPOINT service ssh restart && /bin/bash
