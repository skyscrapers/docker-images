FROM ubuntu:xenial
ARG PACKER_VERSION
ARG G10K_VERSION

# Check for mandatory build arguments
RUN test -n "$PACKER_VERSION"
RUN test -n "$G10K_VERSION"

RUN set -ex \
    && apt update \
    && apt -y install \
        unzip \
        openssl \
        wget

RUN set -ex \
    && wget https://github.com/xorpaul/g10k/releases/download/v${G10K_VERSION}/g10k-linux-amd64.zip \
    && unzip g10k-linux-amd64.zip -d /bin \
    && rm -f g10k-linux-amd64.zip

RUN set -ex \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS \
    && sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS \
    && sha256sum -c --status packer_${PACKER_VERSION}_SHA256SUMS \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip

FROM alpine:latest
ARG PACKER_VERSION
ARG G10K_VERSION
LABEL packer=$PACKER_VERSION
LABEL g10k=$G10K_VERSION
RUN apk --no-cache add git bash openssl openssh make
COPY --from=0 /bin/packer /bin/packer
COPY --from=0 /bin/g10k /bin/g10k
ENTRYPOINT ["/bin/packer"]
