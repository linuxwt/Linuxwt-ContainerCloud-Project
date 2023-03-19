#!/bin/bash

ipv4=`ip a |grep "192.168" |tr "\t" " "|tr -s " "|cut -d ' ' -f3|cut -d/ -f1`
ipv6=`ip a |grep "2409:8080" |tr "\t" " "|tr -s " "|cut -d ' ' -f3|cut -d/ -f1`

cat > kubeadm-join-config.yaml << EOF
apiVersion: kubeadm.k8s.io/v1beta2
kind: JoinConfiguration
discovery:
  bootstrapToken:
    apiServerEndpoint: 192.168.202.70:16444
    token: "npvutc.to1t07vsava8qdnl"
    caCertHashes:
    - "sha256:e4882f8073186424a4473cc06916baac519acc990b1e955cbe5c8086cf11d94c"
nodeRegistration:
  kubeletExtraArgs:
    node-ip: ${ipv4},${ipv6}
EOF
