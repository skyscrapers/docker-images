FROM alpine:3.6

ARG VCS_REF
ARG VCS_URL
ARG HUGO_VERSION

LABEL maintainer="Skyscrapers <info@skyscrapers.eu>" \
      org.label-schema.version=$HUGO_VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

# Install pygments (for syntax highlighting)
RUN apk update && apk add py-pygments && apk add git && apk add bash && rm -rf /var/cache/apk/*

# Install hugo. External script downloads and extracts
ADD hugo /usr/local/hugo
