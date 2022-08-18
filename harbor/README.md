# 为了能通过https://harbor.cmdicncf.org来访问habor
# 通过一键生成证书脚本create_self-signed-cert.sh来生成证书，并将证书复制到目录
# /etc/docker/certs.d/harbor.cmdi.org/下，注意此目录
# 证书对格式有严格要求，证书分别为harbor.cmdicncf.org.cert
# harbor.cmdicncf.org.key ca.crt   
docker login https://harbor.cmdicncf.org
