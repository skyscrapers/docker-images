#!/bin/sh

set -e

if [ ! -z ${OAUTH_CREDS_VAULT_PATH} ]; then
  if [ -z ${VAULT_URL} ] || [ -z ${VAULT_AUTH_PARAM} ] || [ -z ${VAULT_AUTH_METHOD} ]; then
    echo 'When fetching the OAuth2 credentials from Vault you need to provide the $VAULT_URL, $VAULT_AUTH_PARAM and $VAULT_AUTH_METHOD variables.'
    exit 1
  fi

  /bin/vault auth -address=${VAULT_URL} -method=${VAULT_AUTH_METHOD} `echo -n ${VAULT_AUTH_PARAM} | tr ',' ' '`
  VAULT_DATA=$(/bin/vault read -address=${VAULT_URL} -format=json ${OAUTH_CREDS_VAULT_PATH})
  export OAUTH2_PROXY_CLIENT_ID=$(echo $VAULT_DATA | jq -r '.data["client-id"]')
  export OAUTH2_PROXY_CLIENT_SECRET=$(echo $VAULT_DATA | jq -r '.data["client-secret"]')
fi

/bin/oauth2_proxy "$@"
