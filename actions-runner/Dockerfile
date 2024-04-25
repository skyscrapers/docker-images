FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-jammy as build
RUN apt-get update -y \
  && apt-get install -y \
  jq \
  git \
  curl \
  unzip \
  zip \
  ssh

FROM ghcr.io/actions/actions-runner:latest

COPY --from=build /usr/bin/jq /usr/bin/jq
COPY --from=build /usr/bin/git /usr/bin/git
COPY --from=build /usr/bin/curl /usr/bin/curl
COPY --from=build /usr/bin/unzip /usr/bin/unzip
COPY --from=build /usr/bin/zip /usr/bin/zip
COPY --from=build /usr/bin/ssh* /usr/bin/
COPY --from=build /usr/lib/ /usr/lib/
