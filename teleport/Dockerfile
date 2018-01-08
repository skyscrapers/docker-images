FROM debian:jessie

ENV DYNAMODB_REGION="eu-west-1" \
    ENABLE_AUTH="yes" \
    ENABLE_PROXY="yes" \
    DATA_DIR="/var/lib/teleport" \
    LOG_OUTPUT="stdout" \
    LOG_SEVERITY="ERROR"

ADD teleport/tsh /usr/local/bin/tsh
ADD teleport/tctl /usr/local/bin/tctl
ADD teleport/teleport /usr/local/bin/teleport

ADD entrypoint.sh /opt/entrypoint.sh
ADD teleport.yaml /etc/teleport_template.yaml

RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
