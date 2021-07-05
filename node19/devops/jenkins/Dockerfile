FROM jenkinsci/blueocean:latest

USER root

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone 

WORKDIR /usr
RUN mkdir /usr/local/maven
ADD apache-maven-3.5.4-bin.tar.gz /usr/local/maven
RUN ln -s /usr/local/maven/apache-maven-3.5.4 /usr/local/maven/maven
ENV MAVEN_HOME /usr/local/maven/maven
ENV PATH ${MAVEN_HOME}/bin:$PATH

