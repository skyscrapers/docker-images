ARG TF_VERSION=1.1.9

FROM ljfranklin/terraform-resource:${TF_VERSION}

ARG KUBECTL_VERSION=v1.22.10

# Install kubectl (same version of aws esk)
# https://github.com/alpine-docker/k8s/blob/master/Dockerfile
RUN curl -sLO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
  mv kubectl /usr/bin/kubectl && \
  chmod +x /usr/bin/kubectl

# Install awscli
# https://github.com/alpine-docker/k8s/blob/master/Dockerfile
RUN apk add --update --no-cache python3 && \
  python3 -m ensurepip && \
  pip3 install --upgrade pip && \
  pip3 install awscli && \
  pip3 cache purge
