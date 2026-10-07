# Serves the 02-no-matter-what challenge over SSH.
# build: docker build -f deploy/Dockerfile -t 02-no-matter-what-deploy ..
# run:   docker run -d -p <host-port>:22 --name 02-no-matter-what-container \
#            02-no-matter-what-deploy
FROM ubuntu:20.04

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        ssh sudo \
 && rm -rf /var/lib/apt/lists/*

# Flag fragments and SSH password are injected at build time via build args.
# FLAG_PATHS is a pipe-separated list of paths; FLAG_VALUES is the matching values.
ARG FLAG_PATHS="/O|/W|/A|/S|/P|/C|/T|/F"
ARG FLAG_VALUES="For|tun|e_f|avo|rs_|the|_bo|ld"
ARG PASSWORD="CTF_PASSWORD"
RUN set -e; \
    IFS='|' read -ra _p <<< "${FLAG_PATHS}"; \
    IFS='|' read -ra _v <<< "${FLAG_VALUES}"; \
    for _i in "${!_p[@]}"; do \
        mkdir -p "$(dirname "${_p[$_i]}")"; \
        printf '%s' "${_v[$_i]}" > "${_p[$_i]}"; \
    done
COPY deploy/setup /
RUN /setup && rm -f /O /W /A /S /P /C /T /F /setup

RUN mkdir -p /run/sshd && ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
