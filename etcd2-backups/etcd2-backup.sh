/usr/bin/etcdctl backup --data-dir=${ETCD_DATA_DIR} --backup-dir=${ETCD_BACKUP_DIR}
aws s3 cp ${ETCD_BACKUP_DIR} s3://${KOPS_STATE_BUCKET}/${K8S_CLUSTER_NAME}/backups/${ETCD_NODE}
