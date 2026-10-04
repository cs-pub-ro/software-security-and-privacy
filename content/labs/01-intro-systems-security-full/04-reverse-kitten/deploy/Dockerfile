# Serves the 04-reverse-kitten challenge over SSH.
# build: docker build -f deploy/Dockerfile -t 04-reverse-kitten-deploy ..
# run:   docker run -d -p <host-port>:22 --cap-add=cap_dac_read_search \
#            --name 04-reverse-kitten-container 04-reverse-kitten-deploy
# (the capability is only needed by challenges whose setup grants a file one)
FROM ubuntu:20.04

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        ssh sudo libcap2-bin \
 && rm -rf /var/lib/apt/lists/*

# The flag and the setup script are planted, then removed from the image.
# setup creates the ctf user, plants the flag and installs the weakness.
COPY flag deploy/setup /
RUN /setup && rm -f /flag /setup

# Run sshd directly: the container has no init, so generate host keys and keep
# sshd in the foreground.
RUN mkdir -p /run/sshd && ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
