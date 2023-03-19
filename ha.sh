cat >/etc/haproxy/haproxy.cfg<<"EOF"
global
 maxconn 2000
 ulimit-n 16384
 log 127.0.0.1 local0 err
 stats timeout 30s

defaults
 log global
 mode http
 option httplog
 timeout connect 5000
 timeout client 50000
 timeout server 50000
 timeout http-request 15s
 timeout http-keep-alive 15s

frontend monitor-in
 bind *:33306
 mode http
 option httplog
 monitor-uri /monitor

frontend k8s-master
 bind *:16444
 bind 127.0.0.1:16444
 bind :::16444
 mode tcp
 option tcplog
 tcp-request inspect-delay 5s
 default_backend k8s-master

backend k8s-master
 mode tcp
 option tcplog
 option tcp-check
 balance roundrobin
 default-server inter 10s downinter 5s rise 2 fall 2 slowstart 60s maxconn 250 maxqueue 256 weight 100
 server  cmdicncf12  192.168.202.12:6443 check
 server  cmdicncf13  192.168.202.13:6443 check
 server  cmdicncf14  192.168.202.14:6443 check
 server  cmdicncf12_IPv6  2409:8080:5801:824f:2::12:6443 check
 server  cmdicncf13_IPv6  2409:8080:5801:824f:2::13:6443 check
 server  cmdicncf14_IPv6  2409:8080:5801:824f:2::14:6443 check
EOF
systemctl start haproxy  && systemctl enable haproxy
