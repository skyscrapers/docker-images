#!/bin/bash
 
if [ ! -z ${DYNAMODB_REGION} ];
    export DYNAMODB_REGION=eu-west-1

if [ ! -z ${ENABLE_AUTH} ];
    export ENABLE_AUTH=yes

if [ ! -z ${ENABLE_PROXY} ];
    export ENABLE_PROXY=yes
    
if [ ! -z ${TOKENS} -a  ${ENABLE_AUTH} == 'yes' ];
    echo 'ERROR please fill in the $TOKENS environment variable'
    exit 1

if [ ! -z ${CLUSTER_NAME} -a  ${ENABLE_AUTH} == 'yes' ];
    echo 'ERROR please fill in the $TOKENS environment variable'
    exit 1

if [ ! -z ${AUTH_SERVER} -a ${ENABLE_PROXY} == 'yes' ];
    echo 'ERROR please fill in the $AUTH_SERVER environment variable'
    exit 1

if [ ! -z ${DYNAMODB_TABLE} -a  ${ENABLE_AUTH} == 'yes' ];
    echo 'ERROR please fill in the $DYNAMODB_TABLE environment variable'
    exit 1
    
envsubst < "/etc/teleport.yaml" > "/etc/teleport.yaml"

exec /usr/local/bin/teleport start -c /etc/teleport.yaml
