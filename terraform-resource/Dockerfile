ARG TF_VERSION=1.1.9
ARG KUBECTL_VERSION=1.24.0

FROM ljfranklin/terraform-resource:${TF_VERSION}

# Install kubectl (same version of aws esk)
# https://github.com/alpine-docker/k8s/blob/master/Dockerfile
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  mv kubectl /usr/bin/kubectl && \
  chmod +x /usr/bin/kubectl

# Install awscli
# https://github.com/alpine-docker/k8s/blob/master/Dockerfile
RUN apk add --update --no-cache python3 && \
  python3 -m ensurepip && \
  pip3 install --upgrade pip && \
  pip3 install awscli && \
  pip3 cache purge

# Install aws-iam-authenticator
# https://github.com/alpine-docker/k8s/blob/master/Dockerfile
RUN authenticator=$(aws --no-sign-request s3 ls s3://amazon-eks --recursive |grep aws-iam-authenticator$|grep amd64 |awk '{print $NF}' |sort -V|tail -1) && \
  aws --no-sign-request s3 cp s3://amazon-eks/${authenticator} /usr/bin/aws-iam-authenticator && \
  chmod +x /usr/bin/aws-iam-authenticator
