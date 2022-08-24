#!/bin/bash

a=$(grep -Eh '"version"' package.json | awk -F ':' '{print $2}' | awk -F '"' '{print $2}')

cat <<EOF> front.yaml
apiVersion: apps/v1
kind: Deployment 
metadata: 
  name: front
  namespace: devops
spec: 
  selector:
    matchLabels:
      name: front
  template: 
    metadata: 
      labels: 
        name: front
    spec: 
      containers: 
        - name: front
          image: 10.0.0.19:30002/xj/front:$a
          imagePullPolicy: IfNotPresent
          ports: 
            - containerPort: 8090
          volumeMounts:
            - name: tz-config
              mountPath: /etc/localtime
            - name: dockersock
              mountPath: "/var/run/docker.sock"
            - name: dockercli
              mountPath: "/usr/bin/docker"
            - name: dockerdaemon
              mountPath: /etc/docker/daemon.json
              subPath: daemon.json
      imagePullSecrets:
      - name: harbor-secret
      nodeSelector:
        app: devops
      volumes:
      - name: tz-config
        hostPath:
          path: /usr/share/zoneinfo/Asia/Shanghai
      - name: dockerdaemon
        configMap:
          name: jenkins-configmap
          items:
          - key: daemon.json
            path: daemon.json
      - name: dockersock
        hostPath:
          path: /var/run/docker.sock
      - name: dockercli
        hostPath:
          path: /usr/bin/docker
---
kind: Service
apiVersion: v1
metadata:
  name: front-svc
  namespace: devops
  labels:
    name: front
  annotations:
    description: Exposes Front  Service
spec:
  type: NodePort
  selector:     
    name: front    
  ports:
    - name: front
      port: 8090
      targetPort: 8090
      nodePort: 30103
EOF

apk add sshpass
sshpass -p 12ZrN\@aQQ7 ssh -o StrictHostKeyChecking=no  10.0.0.19 'if [ -f front.yaml ];then rm -f front.yaml;fi'
sshpass -p 12ZrN\@aQQ7 scp -o StrictHostKeyChecking=no  front.yaml 10.0.0.19:/root/deploy
sshpass -p 12ZrN\@aQQ7 ssh -o StrictHostKeyChecking=no  10.0.0.19 'if [ $(kubectl get deploy -n devops | grep front | wc -l) -eq 1 ];then  kubectl delete -n devops deploy front && kubectl delete -n devops svc front-svc &&  kubectl create -f /root/deploy/front.yaml;else kubectl create -f /root/deploy/front.yaml;fi'
