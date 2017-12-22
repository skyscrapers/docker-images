#!/bin/sh

cat > awslogs.conf <<EOF
[general]
state_file = /opt/awslogs-agent-state
EOF

push_log() {
  DEFAULT_LOG_STREAM_NAME='{instance_id}'
  cat >> awslogs.conf <<EOF
[${1}]
file = ${1}
buffer_duration = 5000
log_stream_name = ${3:-$DEFAULT_LOG_STREAM_NAME}
initial_position = start_of_file
log_group_name = ${2}
EOF
}

aws configure set plugins.cwlogs cwlogs
aws configure set default.region $AWS_REGION

for mapping in "$@"
do
  IFS=":"
  push_log $mapping
done

aws logs push --config-file awslogs.conf
