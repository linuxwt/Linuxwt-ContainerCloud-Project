#!/bin/bash

###########禁用###############################
sed -i 's/enforcing/disabled/g' /etc/sysconfig/selinux
setenforce 0

############创建自获取包制作共享源################
for i in ansible haproxy keepalived expect ipvs ntp kubeadm nfs createrepo glusterfs glusterfsgeo glusterfsserver

do

    mkdir -p /var/ftp/pub/$i
    cp /root/cmcc-xj/${i}dir/* /var/ftp/pub/$i
    createrepo /var/ftp/pub/$i

##############创建共享源配置文件######################
cat <<EOF>> /etc/yum.repos.d/share-vsftpd.repo
[$i]
name=$i
baseurl=ftp://10.235.9.1/pub/$i
gpgcheck=0
enabled=1    
EOF

done

systemctl restart vsftpd && systemctl enable vsftpd && systemctl daemon-reload

yum makecache && yum -y install ansible expect ntp ntpdate
