#!/bin/sh

set -e

cd /opt/zenhub-charts
./manage.py migrate
# automate mapping unknown pipelines to Closed
sed -i -e "s/int(input('Select one: '))/5/" boards/fetcher/fetch.py 
echo $REPOS_LIST | ./manage.py fetch --initial 
celery -A zenhub_charts worker -B -l info &> celery.log &
./manage.py runserver 0.0.0.0:8080

exec "$@"
