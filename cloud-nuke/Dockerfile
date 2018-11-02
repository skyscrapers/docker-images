FROM alpine:latest

# This is the release of cloud-nuke to pull in.
ARG CLOUD_NUKE_VERSION=v0.1.4

RUN apk add --no-cache ca-certificates python jq && \
    apk add --no-cache --virtual .build-deps curl py-pip python-dev build-base && \
    curl -sL "https://github.com/gruntwork-io/cloud-nuke/releases/download/${CLOUD_NUKE_VERSION}/cloud-nuke_linux_amd64" -o "/bin/cloud-nuke" && \
    chmod +x /bin/cloud-nuke && \
    pip install awscli && \
    apk --purge del .build-deps && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "/bin/cloud-nuke" ]
