FROM ghcr.io/actions/actions-runner:latest

ARG TARGETOS=linux
ARG TARGETARCH
ARG DEBIAN_FRONTEND=noninteractive
USER root

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
  jq \
  git \
  curl \
  unzip \
  zip \
  openssh-client \
  && rm -rf /var/lib/apt/lists/*

RUN export RUNNER_ARCH="${TARGETARCH}" && \
  if [ "${RUNNER_ARCH}" = "amd64" ]; then export AWS_ARCH="x86_64" ; fi && \
  if [ "${RUNNER_ARCH}" = "arm64" ]; then export AWS_ARCH="aarch64" ; fi && \
  curl \
  --fail \
  --silent \
  --location \
  --output "awscliv2.zip" \
  "https://awscli.amazonaws.com/awscli-exe-${TARGETOS}-${AWS_ARCH}.zip" && \
  unzip -qq awscliv2.zip && \
  ./aws/install && \
  rm -rf \
  awscliv2.zip \
  aws/ \
  /usr/local/aws-cli/v2/current/dist/aws_completer \
  /usr/local/bin/aws_completer \
  /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
  /usr/local/aws-cli/v2/current/dist/awscli/examples && \
  find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete

RUN curl \
  --fail \
  --silent \
  --location \
  --output kubectl \
  "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" \
  && chmod +x kubectl \
  && mv kubectl /usr/bin/kubectl
