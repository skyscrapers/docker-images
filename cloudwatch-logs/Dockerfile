FROM alpine:3.6

ENV AWS_REGION=eu-west-1

RUN apk add --update \
      openssl \
      ca-certificates \
      groff \
      less \
      python && \
    apk --update add --virtual build-dependencies \
      py-pip \
      python-dev \
      build-base && \
    pip install awscli-cwlogs && \
    apk --purge del build-dependencies && \
    rm -rf /var/cache/apk/*

ADD entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
