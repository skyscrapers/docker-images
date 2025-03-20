# Versions
ARG ALPINE_VERSION=3.20
ARG TARGETARCH

FROM ghcr.io/skyscrapers/terragrunt as source

COPY --from=source /usr/local/bin/kubectl /usr/local/bin/kubectl

RUN apk add --update --no-cache aws-cli
RUN aws --version
