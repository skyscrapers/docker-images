FROM alpine:3.9

ARG AWSCLI_VERSION=1.16.97
ARG KOPS_VERSION=1.11.0
ARG KUBECTL_VERSION=v1.13.3

RUN apk -v --update add \
      python \
      py-pip \
      groff \
      less \
      mailcap \
      jq \
      curl \
      && \
    pip install --upgrade --no-cache-dir awscli==$AWSCLI_VERSION && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

RUN curl -sLo /usr/local/bin/kops https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 && \
    curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl

RUN chmod +x /usr/local/bin/kops /usr/local/bin/kubectl
