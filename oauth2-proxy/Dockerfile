FROM alpine:3.6

ADD oauth2_proxy /bin/oauth2_proxy

RUN apk add --no-cache ca-certificates

ENTRYPOINT [ "/bin/oauth2_proxy" ]
