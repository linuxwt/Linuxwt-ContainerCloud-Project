#!/bin/bash

mkdir -p /var/lib/etcd/etcd_bak/$(date "+%Y%m%d")
dir=$(date "+%Y%m%d")

ETCDCTL_API=3 etcdctl --endpoints=https://172.19.159.4:2379  --cacert=/etc/etcd/ssl/ca.pem  --cert=/etc/etcd/ssl/etcd.pem  --key=/etc/etcd/ssl/etcd-key.pem  snapshot save /var/lib/etcd/etcd_bak/${dir}/etcd_$(date "+%Y%m%d%H%M%S").db

find /var/lib/etcd/etcd_bak -type d -mtime +15 -print0 | xargs -0 rm -rf
