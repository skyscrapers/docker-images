#!/bin/sh

set -e

cd /opt/zenhub-charts
./manage.py migrate

"$@"
