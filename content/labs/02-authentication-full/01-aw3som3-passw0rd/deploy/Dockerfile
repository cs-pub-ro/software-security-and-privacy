# build: docker build -t sis-02_awesome-password .
# run: docker run -dit --cap-add=cap_dac_read_search --name sis-02_awesome-password -p CTF_PORT:22 sis-02_awesome-password
# stop: docker stop sis-02_awesome-password
FROM ubuntu:20.04

RUN apt-get -y update; apt-get -y install ssh; apt-get install -y libcap2 libcap2-bin; apt-get -y update --fix-missing

COPY flag setup /
RUN /setup; rm /flag /setup

ENTRYPOINT service ssh restart && /bin/bash
