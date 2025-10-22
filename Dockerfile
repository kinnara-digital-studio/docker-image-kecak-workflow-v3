FROM tomcat:9.0.93-jdk11

# install cron and Git LFS

RUN rm -rf /usr/local/tomcat/webapps/*

# transfer any .war files into webapps
COPY *.war /usr/local/tomcat/webapps/

RUN mkdir /usr/local/tomcat/wflow ; \
    echo '' >> /usr/local/tomcat/wflow/app_datasource.properties ; \
    echo '' >> /usr/local/tomcat/wflow/app_datasource-default.properties ; \
    chmod -R 755 /usr/local/tomcat/wflow/

COPY lib/catalina.properties /usr/local/tomcat/conf/
COPY lib/tomcat.sh /usr/local/tomcat/
COPY lib/wait-for-it /usr/bin/
# COPY lib/app_datasource.properties /usr/local/tomcat/wflow/
# COPY lib/app_datasource-default.properties /usr/local/tomcat/wflow/
# COPY sql-script /usr/local/tomcat/sql-script

EXPOSE 8080
EXPOSE 8000

ENV JAVA_OPTS=${JAVA_OPTS}
#ENV TOMCAT_DEBUG=${TOMCAT_DEBUG}

CMD ["/usr/local/tomcat/tomcat.sh", "start"]
