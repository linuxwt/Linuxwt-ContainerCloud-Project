FROM quay.io/fluentd_elasticsearch/fluentd:v2.7.0

USER root
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone
