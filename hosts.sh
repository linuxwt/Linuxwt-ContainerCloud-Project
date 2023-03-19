#!/bin/bash   

for i in {11..24}
do
    echo 192.168.202.$i cmdicncf$i >> /etc/hosts
done
