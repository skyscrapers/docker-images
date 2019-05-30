FROM alpine:latest

# This is the release of spruce to pull in.
ARG SPRUCE_VERSION=v1.20.0

RUN apk add --no-cache ca-certificates jq && \
  apk add --no-cache --virtual .build-deps curl && \
  curl -sL "https://github.com/geofffranks/spruce/releases/download/${SPRUCE_VERSION}/spruce-linux-amd64" -o "/bin/spruce" && \
  chmod +x /bin/spruce && \
  apk --purge del .build-deps && \
  rm -rf /var/cache/apk/*

ENTRYPOINT [ "/bin/spruce" ]
