FROM amazon/aws-cli:latest
ARG KUBECTL_VERSION=v1.18.5

RUN yum update -y \
  && yum install -y jq \
  && curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && yum clean all

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["--help"]
