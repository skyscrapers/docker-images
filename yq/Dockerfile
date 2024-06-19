FROM alpine:latest

RUN apk -v --update add jq yq && \
  rm /var/cache/apk/*

ENTRYPOINT ["yq"]
