FROM python:3

ADD entrypoint.sh /opt/entrypoint.sh

RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/Adphorus/zenhub-charts.git /opt/zenhub-charts && \
    cd /opt/zenhub-charts && \
    pip install -r requirements/base.txt && \
    chmod +x /opt/entrypoint.sh

ENTRYPOINT [ "/opt/entrypoint.sh" ]

