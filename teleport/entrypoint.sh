#!/bin/bash

set -e

create_admin_user () {
  set +e
  sleep 60 # wait a minute until the auth server is up
  echo "Creating bootstrap admin teleport user"
  create_output=$(/usr/local/bin/tctl users add admin root)
  status=$?

  if [ ${status} -ne 0 ]; then
    echo "admin user is already created. Skipping"
  else
    echo "$create_output"
  fi
  set -e
}

if [ -z "${CLUSTER_NAME}" ] && [ "${ENABLE_AUTH}" == "yes" ]; then
  echo 'ERROR please fill in the $CLUSTER_NAME environment variable'
  exit 1
fi

if [ -z "${DYNAMODB_TABLE}" ] && [ "${ENABLE_AUTH}" == "yes" ]; then
  echo 'ERROR please fill in the $DYNAMODB_TABLE environment variable'
  exit 1
fi

if [ -z "${AUTH_SERVERS}" ] && [ "${ENABLE_PROXY}" == "yes" ]; then
  echo 'ERROR please provide at least one auth server in the $AUTH_SERVERS environment variable'
  exit 1
fi

if [ -z "${AUTH_TOKEN}" ] && [ "${ENABLE_AUTH}" == "no" ]; then
  echo 'ERROR please provide an $AUTH_TOKEN to register with an auth server'
  exit 1
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

AUTH_TOKEN_=""
if [ ! -z "${AUTH_TOKEN}" ]; then
  AUTH_TOKEN_="auth_token: ${AUTH_TOKEN}"
fi
export AUTH_TOKEN_

envsubst < "/etc/teleport_template.yaml" > "/etc/teleport.yaml"

if [ "${ENABLE_AUTH}" == "yes" ] && [ "${CREATE_ADMIN_USER}" == "yes" ]; then
  create_admin_user &
fi

if [ "${ADVERTISE_EC2_IP}" == "yes" ]; then
  ADVERTISE_IP_="advertise_ip: $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"
else
  ADVERTISE_IP_=""
fi
export ADVERTISE_IP_

exec /usr/local/bin/teleport start -c /etc/teleport.yaml
