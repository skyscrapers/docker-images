#!/bin/bash

if [ -z "${CLUSTER_NAME}" -a "${ENABLE_AUTH}" == "yes" ]; then
  echo 'ERROR please fill in the $CLUSTER_NAME environment variable'
  exit 1
fi

if [ -z "${DYNAMODB_TABLE}" -a "${ENABLE_AUTH}" == "yes" ]; then
  echo 'ERROR please fill in the $DYNAMODB_TABLE environment variable'
  exit 1
fi

if [ -z "${AUTH_SERVERS}" -a "${ENABLE_PROXY}" == "yes" ]; then
  echo 'ERROR please provide at least one auth server in the $AUTH_SERVERS environment variable'
  exit 1
fi

if [ -z "${DYNAMODB_REGION}" ]; then
  export DYNAMODB_REGION=eu-west-1
fi

if [ -z "${ENABLE_AUTH}" ]; then
  export ENABLE_AUTH=yes
fi

if [ -z "${ENABLE_PROXY}" ]; then
  export ENABLE_PROXY=yes
fi

TOKENS_=""
if [ ! -z "${TOKENS}" ]; then
  TOKENS_="tokens:
"

  for t in ${TOKENS}; do
    TOKENS_="${TOKENS_}    - ${t}
"
  done
fi
export TOKENS_

AUTH_SERVERS_=""
if [ ! -z "${AUTH_SERVERS}" ]; then
  AUTH_SERVERS_="auth_servers:
"

  for a in ${AUTH_SERVERS}; do
    AUTH_SERVERS_="${AUTH_SERVERS_}    - ${a}
"
  done
fi
export AUTH_SERVERS_

envsubst < "/etc/teleport.yaml" > "/etc/teleport.yaml"

exec /usr/local/bin/teleport start -c /etc/teleport.yaml
