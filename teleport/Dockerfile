FROM debian:jessie

ADD teleport/tsh /usr/local/bin/tsh
ADD teleport/tctl /usr/local/bin/tctl
ADD teleport/teleport /usr/local/bin/teleport

ADD entrypoint.sh /opt/entrypoint.sh
ADD teleport.yaml /etc/teleport_template.yaml

WORKDIR /opt

ENTRYPOINT ["entrypoint.sh"]
