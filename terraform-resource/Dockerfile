ARG TF_VERSION=1.1.9
FROM ljfranklin/terraform-resource:${TF_VERSION}

RUN apk --no-cache --update add aws-cli kubectl && \
  rm -rf /var/cache/apk/*
