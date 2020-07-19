FROM tomcat:9.0.27-jdk8-openjdk

# install cron for scheduler
RUN apt-get update && apt-get -y install cron

COPY kecak.war /usr/local/tomcat/webapps

RUN rm -rf /usr/local/tomcat/webapps/ROOT ; \
    mv /usr/local/tomcat/webapps/kecak.war /usr/local/tomcat/webapps/ROOT.war ; \
    mkdir /usr/local/tomcat/webapps/ROOT ; \
    cd /usr/local/tomcat/webapps/ROOT ; \
    jar -xf /usr/local/tomcat/webapps/ROOT.war ; \
    rm /usr/local/tomcat/webapps/ROOT.war ; \
    chmod -R 755 /usr/local/tomcat/webapps/ROOT/ ; \
    mkdir /usr/local/tomcat/wflow ; \
    echo '' >> /usr/local/tomcat/wflow/app_datasource.properties ; \
    echo '' >> /usr/local/tomcat/wflow/app_datasource-default.properties ; \
    chmod -R 755 /usr/local/tomcat/wflow/

COPY lib/catalina.properties /usr/local/tomcat/conf/
COPY lib/tomcat.sh /usr/local/tomcat/
COPY lib/wait-for-it /usr/bin/

EXPOSE 8080

ENV JAVA_OPTS=${JAVA_OPTS}
ENV TOMCAT_DEBUG=${TOMCAT_DEBUG}

CMD ["/usr/local/tomcat/tomcat.sh", "run"]
