FROM alpine:latest

ARG AWSCLI_VERSION=1.14.5

RUN apk -v --update add python py-pip jq && \
  pip install --upgrade awscli==${AWSCLI_VERSION} && \
  apk -v --purge del py-pip && \
  rm /var/cache/apk/*

VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
