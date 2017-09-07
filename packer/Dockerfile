FROM ruby:2.4.1-alpine3.6
ARG PACKER_VERSION

RUN \
# Check for mandatory build arguments
    : "${PACKER_VERSION:?PACKER_VERSION needs to be set and non-empty. See README.md}"

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
        ruby-dev \
        wget \
    && gem install json r10k --no-ri --no-rdoc

RUN set -ex \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS \
    && sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS \
    && sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENTRYPOINT ["/bin/packer"]
