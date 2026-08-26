ARG ATLANTIS_VERSION=v0.39.0
FROM ghcr.io/runatlantis/atlantis:${ATLANTIS_VERSION}

ARG TARGETARCH

USER root

COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.11.3 /usr/local/bin/sops /usr/local/bin/sops
COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.11.3 /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=ghcr.io/skyscrapers/terragrunt:opentofu_v1.11.3 /usr/local/bin/terragrunt /usr/local/bin/terragrunt

# Note: when atlantis moves to Alpine 3.20 update yq to yq-go: https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.20.0#yq
RUN apk update && \
  apk add aws-cli jq yq git

# terragrunt-atlantis-config generates a per-repo atlantis.yaml whose autoplan
# when_modified lists resolved terragrunt dependencies and module sources, so a
# change to a consumed module or an upstream stack autoplans its dependents
# (skyscrapers/platform#2146). Verified against the release checksums.txt; the
# install step selects the artifact per TARGETARCH (our runners are arm64).
ARG TERRAGRUNT_ATLANTIS_CONFIG_VERSION=1.20.0
RUN set -eux; \
  case "${TARGETARCH}" in \
    amd64) tac_arch=amd64 ;; \
    arm64) tac_arch=arm64 ;; \
    *) echo "unsupported TARGETARCH ${TARGETARCH}" >&2; exit 1 ;; \
  esac; \
  cd /tmp; \
  base="https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}"; \
  tarball="terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_linux_${tac_arch}.tar.gz"; \
  checksums="terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}_checksums.txt"; \
  wget -q "${base}/${tarball}"; \
  wget -q "${base}/${checksums}"; \
  grep " ${tarball}\$" "${checksums}" | sha256sum -c -; \
  tar -xzf "${tarball}"; \
  install -m 0755 "$(find . -type f -name terragrunt-atlantis-config | head -n1)" /usr/local/bin/terragrunt-atlantis-config; \
  rm -rf "/tmp/${tarball}" "/tmp/${checksums}" "/tmp/terragrunt-atlantis-config_${TERRAGRUNT_ATLANTIS_CONFIG_VERSION}"*

RUN aws --version && \
  terragrunt --version && \
  sops --version && \
  tofu --version && \
  terragrunt-atlantis-config version

USER atlantis
