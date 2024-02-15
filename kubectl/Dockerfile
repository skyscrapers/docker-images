ARG AWSCLI_VERSION=latest
ARG KUBECTL_VERSION=latest

FROM skyscrapers/aws-cli:${AWSCLI_VERSION}

RUN curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["--help"]
