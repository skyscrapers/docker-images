ARG ATLANTIS_VERSION=v0.39.0
FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TARGETARCH

USER root

COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.11.3 /usr/local/bin/sops /usr/local/bin/sops
COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.11.3 /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.11.3 /usr/local/bin/terragrunt /usr/local/bin/terragrunt

# yq-go (mikefarah) explicitly: the Atlantis pre-workflow hook uses its expression syntax
RUN apk update && \
  apk add aws-cli jq yq-go git

# terragrunt-atlantis-config generates the atlantis.yaml that makes module and dependency
# changes autoplan their consumers (skyscrapers/platform#2146). Releases ship raw binaries
# per arch; digests pinned from the release SHA256SUMS.
ARG TERRAGRUNT_ATLANTIS_CONFIG_VERSION=1.21.1
ARG TERRAGRUNT_ATLANTIS_CONFIG_SHA256_AMD64=1303113ca64edff78f0861d53eea680552bf79729b3ec605f1f4ed8b81b5a37b
ARG TERRAGRUNT_ATLANTIS_CONFIG_SHA256_ARM64=12f7fa57bc4db0526387436e5fa800ac0f3614e30a692fb5ba08e705f21d9195
RUN set -eu; \
  case "${TARGETARCH}" in \
    amd64) sha="${TERRAGRUNT_ATLANTIS_CONFIG_SHA256_AMD64}" ;; \
    arm64) sha="${TERRAGRUNT_ATLANTIS_CONFIG_SHA256_ARM64}" ;; \
    *) echo "unsupported TARGETARCH ${TARGETARCH}" >&2; exit 1 ;; \
  esac; \
  wget -qO /usr/local/bin/terragrunt-atlantis-config \
    "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}/terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_${TARGETARCH}"; \
  echo "${sha}  /usr/local/bin/terragrunt-atlantis-config" | sha256sum -c -; \
  chmod 0755 /usr/local/bin/terragrunt-atlantis-config

RUN aws --version && \
  terragrunt --version && \
  sops --version && \
  tofu --version && \
  terragrunt-atlantis-config version

USER atlantis
