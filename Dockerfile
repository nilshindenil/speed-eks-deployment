FROM ubuntu:24.04
ENV JAVA_HOME=/u01/middleware/jdk-17.0.1/
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.93/
ENV PATH=${PATH}:${TOMCAT_HOME}bin:${JAVA_HOME}bin

RUN mkdir -p /u01/middleware

WORKDIR /u01/middleware
RUN apt update -y
ADD https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz .
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz .
RUN tar -xzvf apache-tomcat-9.0.93.tar.gz
RUN tar -xzvf openjdk-17.0.1_linux-x64_bin.tar.gz
RUN rm openjdk-17.0.1_linux-x64_bin.tar.gz
RUN rm apache-tomcat-9.0.93.tar.gz

COPY target/speed.war apache-tomcat-9.0.93/webapps
COPY run.sh apache-tomcat-9.0.93/bin
RUN chmod u+x apache-tomcat-9.0.93/bin/run.sh
EXPOSE 8080

ENTRYPOINT ["apache-tomcat-9.0.93/bin/run.sh"]

