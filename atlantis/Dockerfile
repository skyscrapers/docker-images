ARG ATLANTIS_VERSION=v0.33.0
FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TARGETARCH

USER root

COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.9.0 /usr/local/bin/sops /usr/local/bin/sops
COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.9.0 /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.9.0 /usr/local/bin/terragrunt /usr/local/bin/terragrunt

# Note: when atlantis moves to Alpine 3.20 update yq to yq-go: https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.20.0#yq
RUN apk update && \
  apk add aws-cli jq yq git
RUN aws --version && \
  terragrunt --version && \
  sops --version && \
  tofu --version

USER atlantis
