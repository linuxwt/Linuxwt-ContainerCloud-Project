#!/bin/bash

jarfile=$(echo $(ls target/*jar) | awk -F '/' '{print $2}')
jarname=${jarfile%.*}
tag=${jarname#*-}


cat <<EOF> provider.yaml
apiVersion: apps/v1
kind: Deployment 
metadata: 
  name: provider
  namespace: devops
spec: 
  selector:
    matchLabels:
      name: provider
  template: 
    metadata: 
      labels: 
        name: provider
    spec: 
      containers: 
        - name: provider 
          image: 10.0.0.19:30002/xj/com.teng-provider:$tag
          imagePullPolicy: IfNotPresent
          ports: 
            - containerPort: 8083
              name: http-provider
              protocol: TCP
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
  name: provider-svc
  namespace: devops
  labels:
    name: provider
  annotations:
    description: Exposes Provider  Service
spec:
  type: NodePort
  selector:     
    name: provider    
  ports:
    - name: provider
      port: 8083
      targetPort: 8083
      nodePort: 30101
EOF

apk add sshpass
sshpass -p 12ZrN\@aQQ7 ssh -o StrictHostKeyChecking=no  10.0.0.19 'if [ -f provider.yaml ];then rm -f provider.yaml;fi'
sshpass -p 12ZrN\@aQQ7 scp -o StrictHostKeyChecking=no  provider.yaml 10.0.0.19:/root/deploy
sshpass -p 12ZrN\@aQQ7 ssh -o StrictHostKeyChecking=no  10.0.0.19 'if [ $(kubectl get deploy -n devops | grep provider | wc -l) -eq 1 ];then  kubectl delete -n devops deploy provider && kubectl delete -n devops svc provider-svc &&  kubectl create -f /root/deploy/provider.yaml;else kubectl create -f /root/deploy/provider.yaml;fi'
