FROM alpine:latest
ARG SPRUCE_VERSION

RUN apk add -v --update bash curl python3 ca-certificates jq  yq-python coreutils && \
  yq --version

RUN curl -sL "https://github.com/geofffranks/spruce/releases/download/${SPRUCE_VERSION}/spruce-linux-amd64" -o "/bin/spruce" && \
  chmod +x /bin/spruce && \
  /bin/spruce --version

ENTRYPOINT [ "/bin/spruce" ]
