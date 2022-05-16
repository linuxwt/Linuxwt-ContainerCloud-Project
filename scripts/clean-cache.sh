#!/bin/bash

mem_now=`free -m | awk 'NR==2' | awk '{print $4}'`

buff_now=`free -m | awk 'NR==2' | awk '{print $6}'`

if [ $mem_now -le 2048 -o $buff_now -ge 4096 ]; then

sync

sleep 10

echo 1 > /proc/sys/vm/drop_caches

echo 2 > /proc/sys/vm/drop_caches

echo 3 > /proc/sys/vm/drop_caches

echo "--->release memory OK at $(date +%Y%m%d_%H%M%S)" >> /tmp/purgeCache.log

fi
