# build: docker build -t sis-01_cant-find-me .
# run: docker run -dit --name sis-01_cant-find-me -p CTF_PORT:22 sis-01_cant-find-me
# stop: docker stop sis-01_cant-find-me
FROM debian:11

RUN apt-get -y update; apt-get -y install ssh mlocate pwgen; apt-get -y update --fix-missing
COPY flag setup /
RUN /setup; rm /flag /setup

ENTRYPOINT service ssh restart && /bin/bash
