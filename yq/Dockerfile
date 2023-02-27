FROM alpine:latest

RUN apk -v --update add py-pip jq && \
  pip install --upgrade yq && \
  apk -v --purge del py-pip && \
  rm /var/cache/apk/*

ENTRYPOINT ["yq"]
