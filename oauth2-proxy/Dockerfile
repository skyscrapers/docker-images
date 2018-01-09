FROM vault:0.9.1

ENV VAULT_AUTH_METHOD=aws

ADD oauth2_proxy /bin/oauth2_proxy
ADD entrypoint.sh /bin/entrypoint.sh

RUN apk add --no-cache ca-certificates jq && \
    chmod +x /bin/entrypoint.sh && \
    chmod +x /bin/oauth2_proxy

ENTRYPOINT [ "/bin/entrypoint.sh" ]
