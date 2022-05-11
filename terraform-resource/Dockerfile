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
