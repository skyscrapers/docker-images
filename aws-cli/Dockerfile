FROM amazon/aws-cli:latest

RUN yum update -y \
  && yum install -y jq \
  && yum clean all

ENTRYPOINT ["/usr/local/bin/aws"]
