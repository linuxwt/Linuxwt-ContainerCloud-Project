FROM jenkinsci/blueocean:latest

USER root

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone  \


WORKDIR /usr
RUN mkdir /usr/local/maven
ADD apache-maven-3.5.4-bin.tar.gz /usr/local/maven
RUN ln -s /usr/local/maven/apache-maven-3.5.4 /usr/local/maven/maven
ENV MAVEN_HOME /usr/local/maven/maven
ENV PATH ${MAVEN_HOME}/bin:$PATH

RUN mkdir /usr/local/node
ADD node-v14.15.1-linux-x64.tar.gz /usr/local/node
RUN ln -s /usr/local/node/node-v14.15.1-linux-x64 /usr/local/node/node
ENV NODE_HOME /usr/local/node/node
ENV PATH ${NODE_HOME}/bin:$PATH 

RUN mkdir /usr/local/sonar
ADD sonar-scanner-4.6.2.2472-linux /usr/local/sonar/sonar
ENV SONAR_HOME /usr/local/sonar/sonar
ENV PATH ${SONAR_HOME}/bin:$PATH
