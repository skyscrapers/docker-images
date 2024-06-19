FROM alpine:latest

# This is the release of spruce to pull in.
ARG SPRUCE_VERSION=v1.26.0

RUN apk add -v --update bash ca-certificates jq yq coreutils && \
  curl -sL "https://github.com/geofffranks/spruce/releases/download/${SPRUCE_VERSION}/spruce-linux-amd64" -o "/bin/spruce" && \
  chmod +x /bin/spruce && \
  rm -rf /var/cache/apk/* && \
  /bin/spruce --version && \
  jq --version && \
  yq --version

ENTRYPOINT [ "/bin/spruce" ]
