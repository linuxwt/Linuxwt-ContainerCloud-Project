for i in app
do
    ansible $i -m shell -a "kubeadm join 10.235.9.40:16443 --token lcbrfe.3g4hke26qurwy21j --discovery-token-ca-cert-hash \
    sha256:af263b68aa67951d3be774d1da62dee94be4a7a84d0a4296652bf95c837ba3f2"
done
