FROM golang:1.9-alpine
ARG PACKER_VERSION

# Check for mandatory build arguments
RUN test -n "$PACKER_VERSION"

RUN set -ex \
    && apk --no-cache add \
        unzip \
        git \
        openssl \
        wget

RUN go get github.com/xorpaul/g10k
    
RUN set -ex \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS \
    && sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS \
    && sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS \
    && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin \
    && rm -f packer_${PACKER_VERSION}_linux_amd64.zip \
    && cp $GOPATH/bin/g10k /bin/ 

FROM alpine:latest
ARG PACKER_VERSION
LABEL packer=$PACKER_VERSION
RUN apk --no-cache add git openssl openssh make bash
COPY --from=0 /bin/packer /bin/packer
COPY --from=0 /bin/g10k /bin/g10k
ENTRYPOINT ["/bin/packer"]
