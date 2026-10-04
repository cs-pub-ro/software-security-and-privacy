# build: docker build -t sis-01_hit-me-hard .
# run: docker run -dit --cap-add=cap_dac_read_search --name sis-01_hit-me-hard -p CTF_PORT:22 sis-01_hit-me-hard
# stop: docker stop sis-01_hit-me-hard
FROM ubuntu:20.04

RUN apt-get -y update; apt-get -y install ssh; apt-get install -y libcap2 libcap2-bin; apt-get -y update --fix-missing

COPY flag setup /
RUN /setup; rm /flag /setup

ENTRYPOINT service ssh restart && /bin/bash
