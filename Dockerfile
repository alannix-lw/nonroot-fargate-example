FROM lacework/datacollector:latest-sidecar AS agent-build-image

FROM ubuntu:latest

# Lacework Agent: copying the binary
COPY --from=agent-build-image /var/lib/lacework-backup /var/lib/lacework-backup

# Lacework Agent: allow sudo
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    jq \
    sed \
    sudo
RUN echo "nonroot ALL=(ALL) NOPASSWD:SETENV:/var/lib/lacework-backup/lacework-sidecar.sh" > /etc/sudoers.d/nonroot

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

RUN groupadd --gid 5000 nonroot
RUN useradd --home-dir /home/nonroot --create-home --uid 5000 --gid 5000 --shell /bin/sh --skel /dev/null nonroot
USER nonroot

ENTRYPOINT [ "/docker-entrypoint.sh" ]
