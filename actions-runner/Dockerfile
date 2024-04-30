FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-jammy as build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
  && apt-get install -y \
  jq \
  git \
  curl \
  unzip \
  zip \
  ssh

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && mv kubectl /usr/bin/

FROM ghcr.io/actions/actions-runner:latest

COPY --from=build /usr/bin/jq /usr/bin/jq
COPY --from=build /usr/bin/git /usr/bin/git
COPY --from=build /usr/bin/curl /usr/bin/curl
COPY --from=build /usr/bin/unzip /usr/bin/unzip
COPY --from=build /usr/bin/zip /usr/bin/zip
COPY --from=build /usr/bin/ssh* /usr/bin/
COPY --from=build /usr/bin/kubectl /usr/bin/kubectl
COPY --from=build /usr/lib/ /usr/lib/
