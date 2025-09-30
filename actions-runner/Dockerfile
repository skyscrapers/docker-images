FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-jammy as build

ARG TARGETOS
ARG TARGETARCH
ARG DEBIAN_FRONTEND=noninteractive
USER root

RUN apt-get update -y \
  && apt-get install -y \
  jq \
  git \
  curl \
  unzip \
  zip \
  ssh

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
  /usr/local/aws-cli/v2/current/dist/aws_completer \
  /usr/local/bin/aws_completer \
  /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
  /usr/local/aws-cli/v2/current/dist/awscli/examples && \
  find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x kubectl && mv kubectl /usr/bin/ 

FROM ghcr.io/actions/actions-runner:latest

COPY --from=build /usr/bin/jq /usr/bin/jq
COPY --from=build /usr/bin/git /usr/bin/git
COPY --from=build /usr/bin/curl /usr/bin/curl
COPY --from=build /usr/bin/unzip /usr/bin/unzip
COPY --from=build /usr/bin/zip /usr/bin/zip
COPY --from=build /usr/bin/ssh* /usr/bin/
COPY --from=build /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=build /usr/local/bin/ /usr/local/bin/
COPY --from=build /usr/bin/kubectl /usr/bin/kubectl
COPY --from=build /usr/lib/ /usr/lib/
COPY --from=build /lib/ /lib/
