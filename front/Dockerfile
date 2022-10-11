FROM 10.235.9.36:30002/library/nginx:1.22.0-perl
MAINTAINER linuxwt <tengwanginit@gmail.com>

ADD dist.tar.gz  /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html/img \
&&    chmod -R 755 /usr/share/nginx/html/js \
&&    chmod -R 755 /usr/share/nginx/html/fonts \
&&    chmod -R 755 /usr/share/nginx/html/css \
&&    chmod 644 /usr/share/nginx/html/index.html \
&&    chmod 644 /usr/share/nginx/html/logo.png \
&&    rm -f /usr/share/nginx/html/50x.html
