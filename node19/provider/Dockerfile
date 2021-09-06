FROM 10.0.0.19:30002/xj/maven:3.6.3-jdk-8
ADD target/*jar  /tmp
WORKDIR /tmp
CMD java -jar $(ls *.jar)