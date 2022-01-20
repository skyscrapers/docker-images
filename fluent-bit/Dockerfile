ARG FLB_VERSION=1.8.10

## LOKI PLUGIN BUILDER

FROM golang:1.17 as builder_loki

ARG LOKI_PLUGIN_GIT="https://github.com/sencha-dev/loki.git"
ARG LOKI_PLUGIN_BRANCH="feature/fluent-bit-json-parse-tag"

WORKDIR /go/src/app

RUN git clone $LOKI_PLUGIN_GIT loki && \
  cd loki/ && \
  git checkout $LOKI_PLUGIN_BRANCH && \
  make fluent-bit-plugin

## FLUENT-BIT

FROM fluent/fluent-bit:${FLB_VERSION}

COPY plugins.conf /fluent-bit/etc/plugins.conf
COPY --from=logzio/fluent-bit-output:latest /fluent-bit/bin/out_logzio.so /fluent-bit/plugins/out_logzio.so
COPY --from=builder_loki /go/src/app/loki/clients/cmd/fluent-bit/out_grafana_loki.so /fluent-bit/plugins/out_grafana_loki.so

EXPOSE 2020
CMD [ "/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf" ]
