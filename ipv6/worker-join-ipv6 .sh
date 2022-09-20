#!/bin/bash

ipv4=`ip a |grep "10.235" |tr "\t" " "|tr -s " "|cut -d ' ' -f3|cut -d/ -f1`
ipv6=`ip a |grep "2409:807c" |tr "\t" " "|tr -s " "|cut -d ' ' -f3|cut -d/ -f1`

cat > kubeadm-join-config.yaml << EOF
apiVersion: kubeadm.k8s.io/v1beta2
kind: JoinConfiguration
discovery:
  bootstrapToken:
    apiServerEndpoint: 10.235.9.40:16443
    token: "i4x3pa.5mfedqa73ptwoi26"
    caCertHashes:
    - "sha256:33dd8d611009d032c01f4781466a14eeda0f67729efb9cb8756dccd3e9a7f733"
nodeRegistration:
  kubeletExtraArgs:
    node-ip: ${ipv4},${ipv6}
EOF