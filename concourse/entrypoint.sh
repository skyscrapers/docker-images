#!/bin/bash

set -e

if [ ! -z ${_CONCOURSE_KEYS_S3} ]; then aws s3 cp --recursive ${_CONCOURSE_KEYS_S3} /concourse-keys; fi;

## To be removed when concourse fully supports the AWS auth backend
## https://github.com/concourse/concourse/issues/1367
if [ ! -z ${CONCOURSE_VAULT_URL} ] && [ "${CONCOURSE_VAULT_AUTH_BACKEND}" == "aws" ]; then
  export CONCOURSE_VAULT_CLIENT_TOKEN="$(VAULT_ADDR=${CONCOURSE_VAULT_URL} /bin/vault auth -token-only -method=aws `echo -n ${CONCOURSE_VAULT_AUTH_PARAM} | tr ',' ' '`)"
  unset CONCOURSE_VAULT_AUTH_BACKEND
  unset CONCOURSE_VAULT_AUTH_PARAM
fi

if [ ! -z ${CONCOURSE_GITHUB_AUTH_CLIENT_ID} ]; then
  export FLAGS=" \ 
--github-client-id=${CONCOURSE_GITHUB_AUTH_CLIENT_ID} \
--github-client-secret=${CONCOURSE_GITHUB_AUTH_CLIENT_SECRET}"
fi

if [ ! -z ${CONCOURSE_BASIC_AUTH_USERNAME} ]; then
  export FLAGS="${FLAGS} \
--add-local-user ${CONCOURSE_BASIC_AUTH_USERNAME}:${CONCOURSE_BASIC_AUTH_PASSWORD}"
fi

/usr/local/bin/concourse "$@ ${FLAGS}"
