# build: docker build -t sis-02_no-matter-what .
# run: docker run -dit --name sis-02_no-matter-what -p CTF_PORT:22 sis-02_no-matter-what
# stop: docker stop sis-02_no-matter-what
FROM ubuntu:20.04

RUN apt-get -y update; apt-get -y install ssh sudo; apt-get -y update --fix-missing

COPY O W A S P C T F setup /
RUN /setup; rm /O /W /A /S /P /C /T /F /setup

ENTRYPOINT service ssh restart && /bin/bash
