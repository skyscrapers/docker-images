FROM alpine:latest

# This is the release of spruce to pull in.
ARG SPRUCE_VERSION=v1.26.0

RUN apk add -v --update bash python3 ca-certificates jq coreutils && \
  apk add -v --virtual .build-deps curl py-pip && \
  curl -sL "https://github.com/geofffranks/spruce/releases/download/${SPRUCE_VERSION}/spruce-linux-amd64" -o "/bin/spruce" && \
  chmod +x /bin/spruce && \
  pip install --upgrade yq && \
  apk del -v --purge .build-deps && \
  rm -rf /var/cache/apk/*

ENTRYPOINT [ "/bin/spruce" ]
