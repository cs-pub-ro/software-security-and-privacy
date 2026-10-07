# Serves the 03-look-for-me challenge over SSH.
# build: docker build -f deploy/Dockerfile -t 03-look-for-me-deploy ..
# run:   docker run -d -p <host-port>:22 --cap-add=cap_dac_read_search \
#            --name 03-look-for-me-container 03-look-for-me-deploy
# (the capability is only needed by challenges whose setup grants a file one)
FROM ubuntu:20.04

RUN apt-get -y update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
        ssh sudo libcap2-bin \
 && rm -rf /var/lib/apt/lists/*

# Flag and SSH password are injected at build time via build args.
ARG FLAG_PATHS="/flag"
ARG FLAG_VALUES="SSP{placeholder}"
ARG PASSWORD="CTF_PASSWORD"
RUN set -e; \
    IFS='|' read -ra _p <<< "${FLAG_PATHS}"; \
    IFS='|' read -ra _v <<< "${FLAG_VALUES}"; \
    for _i in "${!_p[@]}"; do \
        mkdir -p "$(dirname "${_p[$_i]}")"; \
        printf '%s' "${_v[$_i]}" > "${_p[$_i]}"; \
    done
COPY deploy/setup /
RUN /setup && rm -f /flag /setup

# Run sshd directly: the container has no init, so generate host keys and keep
# sshd in the foreground.
RUN mkdir -p /run/sshd && ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
