FROM debian:stable-slim

ENV FAH_VERSION_PATCH=7.5.1
ENV FAH_VERSION_MINOR=7.5

ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -rm -b /home fah && \
  apt-get update && \
  apt-get install --no-install-recommends -y curl bzip2 ca-certificates && \
  curl -o /tmp/fah.deb https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v${FAH_VERSION_MINOR}/fahclient_${FAH_VERSION_PATCH}_amd64.deb && \
  mkdir -p /etc/fahclient/ && \
  touch /etc/fahclient/config.xml && \
  dpkg --install /tmp/fah.deb && \
  apt-get remove -y curl && \
  apt-get autoremove -y && \
  rm --recursive --verbose --force /tmp/* /var/log/* /var/lib/apt/lists/*

# Web viewer
EXPOSE 7396

USER fah

WORKDIR /home/fah

ENV USER Anonymous
ENV TEAM 0
ENV PASSKEY ""
ENV POWER full
ENV GPU false

ENTRYPOINT ["sh", "-c", "exec FAHClient --web-allow=0/0 --allow=0/0 --user=${USER} --team=${TEAM} --power=${POWER} --gpu=${GPU} --passkey=${PASSKEY}"]
