#!/bin/sh
curl -O -L https://github.com/coreos/etcd/releases/download/v2.3.8/etcd-v2.3.8-linux-amd64.tar.gz
tar xvf etcd-v2.3.8-linux-amd64.tar.gz

docker build -t skyscrapers/etcd2-backup .

rm etcd-v2.3.8-linux-amd64.tar.gz
rm -rf etcd-v2.3.8-linux-amd64
