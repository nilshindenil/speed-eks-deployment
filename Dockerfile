FROM ubuntu:24.04

ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.93/
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.93.tar.gz/

ENV PATH=$PATH:$TOMCAT_HOME/bin

RUN mkdir -p /u01/middleware

WORKDIR /u01/middleware
RUN apt update -y
RUN apt install openjdk-17-jdk -y
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz .
RUN tar -xzvf apache-tomcat-9.0.93.tar.gz
RUN rm apache-tomcat-9.0.93.tar.gz

COPY target/speed.war apache-tomcat-9.0.93/webapps
COPY run.sh apache-tomcat-9.0.93/bin
RUN chmod u+x apache-tomcat-9.0.93/bin/run.sh
EXPOSE 8080

ENTRYPOINT ["apache-tomcat-9.0.93/bin/run.sh"]
