#! /bin/bash
cd /root
CURRENT_DATE=`date +%Y%m%d%H%M%S`
java $JAVA_OPTS -Xloggc:/root/logs/gc_$CURRENT_DATE.log -jar /root/zllms-admin-1.0.0-SNAPSHOT.jar