ARG AWSCLI_VERSION=latest
FROM amazon/aws-cli:${AWSCLI_VERSION}

RUN yum update -y \
  && yum install -y jq \
  && yum clean all

ENTRYPOINT ["/usr/local/bin/aws"]
