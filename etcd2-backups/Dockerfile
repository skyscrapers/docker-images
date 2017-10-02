FROM  alpine:latest

ENV ETCD_DATA_DIR=/var/etcd/data
ENV ETCD_BACKUP_DIR=/backups
ENV KOPS_STATE_BUCKET=''
ENV K8S_CLUSTER_NAME=''

COPY etcd-v2.3.8-linux-amd64/etcdctl /usr/bin/etcdctl
COPY etcd2-backup.sh /usr/bin/etcd2-backup.sh

RUN apk -Uuv add python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

CMD /usr/bin/etcd2-backup.sh
