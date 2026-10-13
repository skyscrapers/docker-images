# Versions
ARG ALPINE_VERSION=3.23
ARG TOFU_VERSION=1.6.2
ARG SOPS_VERSION=v3.13.3

FROM ghcr.io/getsops/sops:${SOPS_VERSION}-alpine as sops
FROM ghcr.io/opentofu/opentofu:${TOFU_VERSION}-minimal as tofu
FROM alpine:${ALPINE_VERSION} as build

ARG TARGETARCH
ARG TERRAGRUNT_VERSION=v1.1.6
ARG KUBECTL_VERSION=v1.37.1
ARG HELM_VERSION=v4.3.0

RUN apk add --update --no-cache curl ca-certificates

RUN curl -fsSLO https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_${TARGETARCH} && \
  curl -fsSLO https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/SHA256SUMS && \
  grep " terragrunt_linux_${TARGETARCH}$" SHA256SUMS > terragrunt.sha256 && \
  sha256sum -c terragrunt.sha256 && \
  chmod +x terragrunt_linux_${TARGETARCH} && \
  mv terragrunt_linux_${TARGETARCH} /usr/local/bin/terragrunt
RUN terragrunt --version

RUN curl -fsSL -o kubectl https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl && \
  curl -fsSLO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256" && \
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/kubectl

RUN curl -fsSLO https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
  curl -fsSLO https://get.helm.sh/helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz.sha256sum && \
  sha256sum -c helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz.sha256sum && \
  tar -xvzf helm-${HELM_VERSION}-linux-${TARGETARCH}.tar.gz && \
  chmod +x linux-${TARGETARCH}/helm && \
  mv linux-${TARGETARCH}/helm /usr/local/bin/helm

FROM alpine:${ALPINE_VERSION}

RUN apk add --update --no-cache aws-cli bash ca-certificates coreutils curl git jq openssh openssl yq-go
RUN aws --version

RUN addgroup -g 1000 terragrunt && \
  adduser -u 1000 -G terragrunt -h /home/terragrunt -s /bin/sh -D terragrunt

COPY --from=sops /usr/local/bin/sops /usr/local/bin/sops
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu
COPY --from=build /usr/local/bin/terragrunt /usr/local/bin/terragrunt
COPY --from=build /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=build /usr/local/bin/helm /usr/local/bin/helm
