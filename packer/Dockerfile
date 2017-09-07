FROM ruby:2.4.1-alpine3.6

RUN set -ex \
	\
	&& apk add --no-cache --virtual --update \
        bash \
        gcc \
        git \
        libc-dev \
        make \
		openssh \
		openssl \
        ruby-dev \
        wget \
    && gem install json r10k --no-ri --no-rdoc

# Adding Packer. Copied from https://github.com/hashicorp/docker-hub-images/blob/master/packer/Dockerfile-light
ENV PACKER_VERSION=1.0.4
ENV PACKER_SHA256SUM=0e10169ef9cf3fd55dcc9dc213b9995170f7712e8a162ca2f5109d62bfbe7529

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN set -ex \
    && sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS \
    && sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENTRYPOINT ["/bin/packer"]
