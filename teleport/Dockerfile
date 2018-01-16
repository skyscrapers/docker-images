FROM debian:jessie

ENV DYNAMODB_REGION="eu-west-1" \
    ENABLE_AUTH="yes" \
    ENABLE_PROXY="yes" \
    ENABLE_NODE="no" \
    LOG_OUTPUT="stdout" \
    LOG_SEVERITY="ERROR" \
    CREATE_ADMIN_USER="yes" \
    ADVERTISE_EC2_IP="yes" \
    SESSION_RECORDING="on"

ADD teleport/tsh /usr/local/bin/tsh
ADD teleport/tctl /usr/local/bin/tctl
ADD teleport/teleport /usr/local/bin/teleport

ADD entrypoint.sh /opt/entrypoint.sh
ADD teleport.yaml /etc/teleport_template.yaml

RUN chmod +x /opt/entrypoint.sh && \
    apt-get update && \
    apt-get install -y gettext-base ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/teleport/log

ENTRYPOINT ["/opt/entrypoint.sh"]
