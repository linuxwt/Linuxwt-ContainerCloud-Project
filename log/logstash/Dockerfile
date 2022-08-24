FROM logstash:7.9.1

USER root
ADD GeoLite2-City_20210713.tar.gz /usr/share/logstash/ 

RUN mv /usr/share/logstash/GeoLite2-City_20210713 /usr/share/logstash/GeoLite2-City \
    && yum -y install geoipupdate \
    && echo "ProductIds GeoLite2-City" >> /etc/GeoIP.conf 


