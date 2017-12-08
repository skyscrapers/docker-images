FROM python:3

COPY entrypoint.sh /opt/entrypoint.sh

RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/Adphorus/zenhub-charts.git /opt/zenhub-charts && \
    cd /opt/zenhub-charts && \
    pip install -r requirements/base.txt && \
    chmod +x /opt/entrypoint.sh

COPY settings_local.py /opt/zenhub-charts/zenhub_charts/settings_local.py
COPY credentials.py /opt/zenhub-charts/zenhub_charts/credentials.py

ENTRYPOINT [ "/opt/entrypoint.sh" ]
