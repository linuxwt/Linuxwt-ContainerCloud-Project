FROM 10.0.0.19:30002/xj/nginx

ADD dist /usr/share/nginx/html/dist
RUN chmod -R 777 /usr/share/nginx/html/dist
RUN echo "server { " > /etc/nginx/conf.d/default.conf
RUN echo  "listen       8090;" >> /etc/nginx/conf.d/default.conf
RUN echo  "server_name  localhost;" >> /etc/nginx/conf.d/default.conf
RUN echo  "absolute_redirect off;" >> /etc/nginx/conf.d/default.conf
RUN echo  "location /xjOM {" >> /etc/nginx/conf.d/default.conf
RUN echo  "alias  /usr/share/nginx/html/dist;" >> /etc/nginx/conf.d/default.conf
RUN echo  "index index.html index.htm;" >> /etc/nginx/conf.d/default.conf
RUN echo  "      } " >> /etc/nginx/conf.d/default.conf
RUN echo  "    }"  >> /etc/nginx/conf.d/default.conf