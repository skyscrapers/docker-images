FROM alpine:latest

# This is the release of aws-nuke to pull in.
ARG AWS_NUKE_VERSION=v2.15.0

RUN apk add --no-cache ca-certificates jq && \
    apk add --no-cache --virtual .build-deps curl && \
    curl -sL "https://github.com/rebuy-de/aws-nuke/releases/download/${AWS_NUKE_VERSION}/aws-nuke-${AWS_NUKE_VERSION}-linux-amd64.tar.gz" -o "/tmp/aws-nuke-${AWS_NUKE_VERSION}-linux-amd64.tar.gz" && \
    tar -xzf "/tmp/aws-nuke-${AWS_NUKE_VERSION}-linux-amd64.tar.gz" && \
    mv "aws-nuke-${AWS_NUKE_VERSION}-linux-amd64" /bin/aws-nuke && \
    chmod +x /bin/aws-nuke && \
    apk --purge del .build-deps && \
    rm -rf /var/cache/apk/* && \
    rm -rf "/tmp/aws-nuke-${AWS_NUKE_VERSION}-linux-amd64.tar.gz"

ENTRYPOINT [ "/bin/aws-nuke" ]
