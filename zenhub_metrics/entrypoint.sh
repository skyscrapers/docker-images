#!/bin/sh

set -e

cd /opt/zenhub-charts
echo  "GITHUB = {'token': '$GITHUB_TOKEN', 'owner': '$GITHUB_USER'}" >> zenhub_charts/credentials.py 
echo  "ZENHUB = {'token': '$ZENHUB_TOKEN'}" >> zenhub_charts/credentials.py
sed -i -e 's/md5/trust/g' /etc/postgresql/*/main/pg_hba.conf
service postgresql start
service redis-server start
./manage.py migrate
sed -i -e "s/DEBUG = False/DEBUG = True/" zenhub_charts/settings.py
# automate mapping unknown pipelines to Closed
sed -i -e "s/int(input('Select one: '))/5/" boards/fetcher/fetch.py 
echo $REPOS_LIST | ./manage.py fetch --initial 
CELERY_BROKER_URL=redis://localhost:6379/0
CELERY_RESULT_BACKEND=redis
celery -A zenhub_charts worker -B -l info &> celery.log &
./manage.py runserver 0.0.0.0:80

exec "$@"
