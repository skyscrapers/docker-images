ARG CONCOURSE_VERSION=5.8.0

FROM alpine:latest as downloader
RUN apk update \
  && apk add --no-cache bash gzip tar ca-certificates wget \
  && wget https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/fly-${CONCOURSE_VERSION}-linux-amd64.tgz -O /tmp/fly.gz \
  && tar xvzfO /tmp/fly.gz > /usr/bin/fly \
  && chmod +x /usr/bin/fly

FROM alpine:latest
RUN apk add --no-cache bash tzdata ca-certificates \
  && update-ca-certificates
COPY --from=downloader /usr/bin/fly /usr/local/bin/fly
RUN chmod +x /usr/local/bin/fly

ENTRYPOINT ["bash"]
