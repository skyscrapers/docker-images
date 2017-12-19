FROM debian:jessie

# ARG TELEPORT_VERSION

ADD teleport/tsh /usr/local/bin/tsh
ADD teleport/tctl /usr/local/bin/tctl
ADD teleport/teleport /usr/local/bin/teleport

ENTRYPOINT ["/usr/local/bin/teleport", "start"]
