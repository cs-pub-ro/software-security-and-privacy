# Serves the 02-no-matter-what challenge over SSH.
# build: docker build -f deploy/Dockerfile -t 02-no-matter-what-deploy ..
# run:   docker run -d -p <host-port>:22 --name 02-no-matter-what-container \
#            02-no-matter-what-deploy
FROM ubuntu:20.04

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        ssh sudo \
 && rm -rf /var/lib/apt/lists/*

# The flag is split across eight files; setup moves them to /usr/local (root
# only) and allows ctf to sha256sum them via sudo.
COPY deploy/O deploy/W deploy/A deploy/S deploy/P deploy/C deploy/T deploy/F deploy/setup /
RUN /setup && rm -f /O /W /A /S /P /C /T /F /setup

RUN mkdir -p /run/sshd && ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
