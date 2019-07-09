FROM alpine:latest

ARG AWSCLI_VERSION=1.16.193

RUN apk -v --update add python py-pip jq && \
  pip install --upgrade awscli==${AWSCLI_VERSION} && \
  apk -v --purge del py-pip && \
  rm /var/cache/apk/*

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
