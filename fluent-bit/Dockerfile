ARG FLB_VERSION=1.8.10
FROM fluent/fluent-bit:${FLB_VERSION}

COPY plugins.conf /fluent-bit/etc/plugins.conf
COPY --from=logzio/fluent-bit-output:latest /fluent-bit/bin/out_logzio.so /fluent-bit/plugins/out_logzio.so
COPY --from=grafana/fluent-bit-plugin-loki:latest /fluent-bit/bin/out_grafana_loki.so /fluent-bit/plugins/out_grafana_loki.so

EXPOSE 2020
CMD [ "/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf" ]
