# Versions
ARG ALPINE_VERSION=3.20
ARG TOFU_VERSION=1.6.2
ARG SOPS_VERSION=v3.8.1

FROM ghcr.io/getsops/sops:${SOPS_VERSION}-alpine as sops
FROM ghcr.io/opentofu/opentofu:${TOFU_VERSION} as tofu

FROM alpine:${ALPINE_VERSION} as build

ARG TARGETARCH
ARG TERRAGRUNT_VERSION=v0.58.6
ARG KUBECTL_VERSION=v1.30.0
ARG HELM_VERSION=v3.15.1

RUN apk update && \
  apk add curl ca-certificates

RUN curl -L \
  https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_${TARGETARCH} -o terragrunt && \
  chmod +x terragrunt && \
  mv terragrunt /usr/local/bin/
RUN terragrunt --version

RUN curl -L -o kubectl https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl && \
  curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256" && \
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/kubectl

RUN curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
  curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz.sha256sum && \
  sha256sum -c helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz.sha256sum && \
  tar -xvzf helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
  chmod +x linux-${TARGETARCH}/helm && \
  mv linux-${TARGETARCH}/helm /usr/local/bin/helm

FROM alpine:${ALPINE_VERSION}

RUN apk update && \
  apk add aws-cli jq yq-go git bash
RUN aws --version

COPY --from=sops /usr/local/bin/sops /usr/local/bin/sops
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=build /usr/local/bin/terragrunt /usr/local/bin/terragrunt
COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=build /usr/local/bin/helm /usr/local/bin/helm
