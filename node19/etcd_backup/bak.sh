#!/bin/bash

######################etcd备份##################################
kubectl  exec -n kube-system etcd-node19 --  etcdctl --endpoints=https://10.0.0.19:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key  snapshot save /var/lib/etcd/etcd_backup/etcd_$(date "+%Y%m%d%H%M%S").db