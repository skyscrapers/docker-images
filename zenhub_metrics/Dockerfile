FROM python:3

ADD entrypoint.sh /opt/entrypoint.sh

RUN apt-get update && \
    apt-get install -y git postgresql redis-server sudo && \
    service postgresql start && \
    git clone https://github.com/Adphorus/zenhub-charts.git /opt/zenhub-charts && \
    cd /opt/zenhub-charts && \
    pip install -r requirements/base.txt && \
    sudo -u postgres createdb zenhub_charts && \
    chmod +x /opt/entrypoint.sh

ENTRYPOINT [ "/opt/entrypoint.sh" ]

