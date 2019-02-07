FROM alpine:latest

ARG AWSCLI_VERSION=1.16.97
ARG KOPS_VERSION=1.11.0
ARG KUBECTL_VERSION=v1.13.3

RUN  apk add --update --no-cache bash python jq ca-certificates groff less \
  && apk add --update --no-cache --virtual build-deps py-pip curl \
  && pip install --upgrade --no-cache-dir awscli==$AWSCLI_VERSION

RUN  curl -sLo /usr/local/bin/kops https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 \
  && curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kops /usr/local/bin/kubectl

RUN  apk del --purge build-deps \
  && rm -f /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/kops"]
CMD ["--help"]
