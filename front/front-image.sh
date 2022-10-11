#!/bin/bash

unzip dist.zip 
cd dist
tar zvcf dist.tar.gz ./*
mv dist.tar.gz ../
cd /root/cmcc-xj/front/front
tag=$(date +%Y-%m-%d'_'%H-%M-%S)
docker build -t front:$tag .

docker tag front:${tag} 10.235.9.36:30002/library/front:${tag}
docker push 10.235.9.36:30002/library/front:${tag}

docker tag front:${tag} 10.235.9.36:30002/library/front:latest
docker push 10.235.9.36:30002/library/front:latest

docker rmi -f front:${tag} 
docker rmi -f 10.235.9.36:30002/library/front:${tag}
docker rmi -f 10.235.9.36:30002/library/front:latest
mv dist.zip dist.zip-$tag
mv dist dist-$tag
mv dist.tar.gz dist.tar.gz-$tag
kubectl apply -f front-deployment.yaml
sleep 30
kubectl get po -n front  | grep front
