ARG FLB_VERSION=1.7.2

## BUILDER

FROM alpine as builder
ARG LOGZIO_SRC=https://github.com/logzio/fluent-bit-logzio-output/raw/master/build/out_logzio-linux.so
ENV LOGZIO_SRC $LOGZIO_SRC

RUN apk add --update curl && \
  mkdir -p /fluent-bit/plugins && \
  curl -L -o "/out_logzio.so" ${LOGZIO_SRC} 

## FLUENT-BIT

FROM fluent/fluent-bit:${FLB_VERSION}

COPY plugins.conf /fluent-bit/etc/plugins.conf
COPY --from=builder /out_logzio.so /fluent-bit/plugins/out_logzio.so

EXPOSE 2020
CMD [ "/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf" ]
