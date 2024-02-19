ARG AWSCLI_VERSION=latest
FROM skyscrapers/aws-cli:${AWSCLI_VERSION}

ARG KUBECTL_VERSION
RUN curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x /usr/local/bin/kubectl


ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["--help"]
