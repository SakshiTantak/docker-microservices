FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt upgrade -y

#INSTALL OPENJDK
RUN apt-get install -y default-jdk

#INSTALL UTILITIES
RUN apt-get update && apt-get install wget tar unzip -y

# INSTALL LIBGTK3 FOR ECLIPSE
RUN apt-get install "libgtk-3*" "libgtksourceview-3.0*" -y

# INSTALL SPRING LIBRARIES
RUN apt-get install -y default-jdk maven
RUN apt-get install -y git wget
RUN cd /root && git clone https://github.com/spring-guides/gs-spring-boot.git
RUN /root/gs-spring-boot/test/run.sh
RUN wget https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/2.3.2.RELEASE/spring-boot-cli-2.3.2.RELEASE-bin.tar.gz -O /tmp/spring-cli.tar.gz
RUN mkdir -p /usr/local/spring-boot
RUN mv /tmp/spring-cli.tar.gz /usr/local/spring-boot
RUN cd /usr/local/spring-boot/ && tar xvzf spring-cli.tar.gz

RUN /usr/local/spring-boot/spring-2.3.2.RELEASE/bin/spring install org.springframework.cloud:spring-cloud-cli:2.2.0.BUILD-SNAPSHOT


#INSTALL TOMCAT
RUN mkdir /usr/local/apache-tomcat-v8.5.57
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz -O /tmp/apache-tomcat-v8.5.57.tar.gz
RUN cd /tmp && tar xvfz apache-tomcat-v8.5.57.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.57/* /usr/local/apache-tomcat-v8.5.57/
EXPOSE 8080

# INSTALL ECLIPSE
RUN wget http://mirror.tspu.ru/eclipse/technology/epp/downloads/release/2020-06/R/eclipse-jee-2020-06-R-linux-gtk-x86_64.tar.gz -P /opt
RUN cd /opt && tar xvzf eclipse-jee-2020-06-R-linux-gtk-x86_64.tar.gz

#INSTALL WEBKIT AND DBUS
RUN apt-get install -y dbus* webkit*

# CREATE RUN SCRIPT
RUN touch startup.sh
RUN chmod +x startup.sh
RUN echo "if [ -z \$DISPLAY+x ]; then\n\t/usr/local/apache-tomcat-v8.5.57/bin/catalina.sh run;\nelse\n\t/opt/eclipse/eclipse&\n\t/usr/local/apache-tomcat-v8.5.57/bin/catalina.sh run\nfi" | cat > startup.sh

COPY TestRIOJavaStack.zip /usr/local/apache-tomcat-v8.5.57/webapps
RUN cd /usr/local/apache-tomcat-v8.5.57/webapps && unzip TestRIOJavaStack.zip

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" | cat >> /root/.bashrc
RUN echo "export JAVA=\$JAVA_HOME/bin" | cat >> /root/.bashrc
RUN echo "export PATH=\$PATH:\$JAVA_HOME:\$JAVA" | cat >> /root/.bashrc

ENTRYPOINT ./startup.sh
