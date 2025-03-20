# Versions
ARG ALPINE_VERSION=3.20
ARG TARGETARCH

FROM ghcr.io/skyscrapers/terragrunt as source
FROM alpine:${ALPINE_VERSION}

RUN apk add --update --no-cache aws-cli bash
RUN aws --version

COPY --from=source /usr/local/bin/kubectl /usr/local/bin/kubectl
