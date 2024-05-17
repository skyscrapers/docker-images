ARG TARGETARCH

ARG SOPS_VERSION=v3.8.1
ARG TOFU_version=1.6.2
ARG TERRAGRUNT_VERSION=v0.58.6
ARG KUBECTL_VERSION=v1.12.7
ARG HELM_VERSION=v2.13.1

FROM alpine:latest as build

RUN apk update && \
  apk add curl ca-certificates
#aws-cli jq yq ca-certificates git bash  curl

# install cosign
COPY --from=gcr.io/projectsigstore/cosign:latest /ko-app/cosign /usr/local/bin/cosign

RUN curl -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.${TARGETARCH} -o /usr/local/bin/sops && \
  curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.txt && \
  curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.pem && \
  curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.sig && \
  cosign verify-blob sops-${SOPS_VERSION}.checksums.txt \
  --certificate sops-${SOPS_VERSION}.checksums.pem \
  --signature sops-${SOPS_VERSION}.checksums.sig \
  --certificate-identity-regexp=https://github.com/getsops \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com && \
  chmod +x /usr/local/bin/sops
RUN sops --version

RUN curl -L https://github.com/opentofu/opentofu/releases/download/v${TOFU_version}/tofu_${TOFU_version}_linux_${TARGETARCH}.zip -o tofu.zip && \
  curl -LO https://github.com/opentofu/opentofu/releases/download/v${TOFU_version}/tofu_${TOFU_version}_SHA256SUMS && \
  curl -LO https://github.com/opentofu/opentofu/releases/download/v${TOFU_version}/tofu_${TOFU_version}_SHA256SUMS.sig && \
  curl -LO https://github.com/opentofu/opentofu/releases/download/v${TOFU_version}/tofu_${TOFU_version}_SHA256SUMS.pem && \
  cosign verify-blob \
  --signature tofu_${TOFU_version}_SHA256SUMS.sig \
  --certificate tofu_${TOFU_version}_SHA256SUMS.pem \
  --certificate-identity https://github.com/opentofu/opentofu/.github/workflows/release.yml@refs/heads/v1.6 \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com tofu_${TOFU_version}_SHA256SUMS && \
  unzip -qq tofu.zip && \
  mv tofu /usr/local/bin/tofu && \
  chmod +x /usr/local/bin/tofu
RUN tofu --version

RUN curl -L \
  https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -o terragrunt && \
  chmod +x terragrunt && \
  mv terragrunt /usr/local/bin/
RUN terragrunt --version

RUN curl -L -o kubectl https://dl.k8s.io/release/${KUBECTL_VERSION}bin/linux/${TARGETARCH}/kubectl && \
  curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256" && \
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/kubectl

RUN curl -L -o helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
  curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz.sha256sum && \
  sha256sum -c helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz.sha256sum && \
  tar -xvzf helm.tar.gz && \
  chmod +x linux-${TARGETARCH}/helm && \
  mv linux-${TARGETARCH}/helm /usr/local/bin/helm

FROM alpine:latest

RUN apk update && \
  apk add aws-cli jq yq git
RUN aws --version

COPY --from=build /usr/local/bin/sops /usr/local/bin/sops
COPY --from=build /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=build /usr/local/bin/terragrunt /usr/local/bin/terragrunt
COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=build /usr/local/bin/helm /usr/local/bin/helm
