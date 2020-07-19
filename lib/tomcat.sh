#!/bin/sh

KECAK_DIR="/usr/local/tomcat"

if [ -z "$JAVA_OPTS" ]
then
    JAVA_OPTS=-Xmx512M
fi

export JAVA_OPTS="${JAVA_OPTS} -Dwflow.home=${KECAK_DIR}/wflow/"

if [ -z "$TOMCAT_DEBUG" ]
then
    catalina.sh $*

else
    export JPDA_ADDRESS=8000
    export JPDA_TRANSPORT=dt_socket
    
    echo ============ WARNING!!!!! port [$JPDA_ADDRESS] is exposed in debug mode ============

    catalina.sh jpda $*
fi
