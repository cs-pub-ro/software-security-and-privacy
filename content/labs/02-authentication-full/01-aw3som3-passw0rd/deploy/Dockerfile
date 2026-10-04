# Serves the 01-aw3som3-passw0rd challenge over SSH.
# build: docker build -f deploy/Dockerfile -t 01-aw3som3-passw0rd-deploy ..
# run:   docker run -d -p <host-port>:22 --cap-add=cap_dac_read_search \
#            --name 01-aw3som3-passw0rd-container 01-aw3som3-passw0rd-deploy
FROM ubuntu:20.04

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        ssh sudo libcap2-bin \
 && rm -rf /var/lib/apt/lists/*

COPY flag deploy/setup /
RUN /setup && rm -f /flag /setup

RUN mkdir -p /run/sshd && ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
