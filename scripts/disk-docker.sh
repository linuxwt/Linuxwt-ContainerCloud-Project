#!/bin/bash

if [ $# -lt 1 ];then
        echo "sorry,ou need the argument,the argument should be the name of a new disk."
        exit -1
fi
echo "d  
n  
p  
1


w  
" | fdisk $1
mkfs.xfs -f ${1}1  
mkdir -p /data/docker
echo "/dev/sdb1 /data/docker xfs defaults 0 0" >> /etc/fstab
mount ${1}1 /data/docker
