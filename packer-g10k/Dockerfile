FROM golang:1.9-alpine3.6
ARG PACKER_VERSION
ARG G10K_VERSION

RUN \
# Check for mandatory build arguments
    : "${PACKER_VERSION:?PACKER_VERSION needs to be set and non-empty. See README.md}"
    : "${G10K_VERSION:?G10K_VERSION needs to be set and non-empty. See README.md}"

RUN set -ex \
	\
	&& apk add --no-cache --virtual --update \
        bash \
        gcc \
        git \
        jq \
        libc-dev \
        make \
	openssh \
	openssl \
        wget

RUN set -ex \
    && wget https://github.com/xorpaul/g10k/releases/download/${G10K_VERSION}/g10k-linux-amd64.zip \
    && mkdir /opt/g10k \
    && cd /opt/g10k \
    && unzip g10k-linux-amd64.zip \
    && rm -f g10k-linux-amd64.zip

RUN set -ex \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS \
    && sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS \
    && sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENTRYPOINT ["/bin/packer"]
