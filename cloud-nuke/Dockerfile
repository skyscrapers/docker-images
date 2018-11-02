FROM alpine:latest

# This is the release of cloud-nuke to pull in.
ARG CLOUD_NUKE_VERSION=v0.1.4

RUN apk add --no-cache ca-certificates && \
    apk add --no-cache --virtual .build-deps curl && \
    curl -sL "https://github.com/gruntwork-io/cloud-nuke/releases/download/${CLOUD_NUKE_VERSION}/cloud-nuke_linux_amd64" -o "/bin/cloud-nuke" && \
    chmod +x /bin/cloud-nuke && \
    apk del .build-deps

ENTRYPOINT [ "/bin/cloud-nuke" ]
