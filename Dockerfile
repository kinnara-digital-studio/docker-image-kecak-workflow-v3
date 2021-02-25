FROM tomcat:9.0.27-jdk8-openjdk

# install cron for scheduler and GIT LFS
RUN apt-get update && apt-get -y install cron && apt-get install -y sudo curl git && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash && \
    sudo apt-get install git-lfs && \
    mkdir -p /src

COPY kecak.war /usr/local/tomcat/webapps

RUN rm -rf /usr/local/tomcat/webapps/ROOT ; \
    mkdir /usr/local/tomcat/wflow ; \
    echo '' >> /usr/local/tomcat/wflow/app_datasource.properties ; \
    echo '' >> /usr/local/tomcat/wflow/app_datasource-default.properties ; \
    chmod -R 755 /usr/local/tomcat/wflow/

COPY lib/catalina.properties /usr/local/tomcat/conf/
COPY lib/tomcat.sh /usr/local/tomcat/
COPY lib/wait-for-it /usr/bin/
COPY lib/server.xml /usr/local/tomcat/conf/

EXPOSE 8080

ENV JAVA_OPTS=${JAVA_OPTS}
ENV TOMCAT_DEBUG=${TOMCAT_DEBUG}

CMD ["/usr/local/tomcat/tomcat.sh", "run"]
