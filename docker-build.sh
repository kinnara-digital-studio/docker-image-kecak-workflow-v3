#!/bin/sh

#JAVA_OPTS=-Xmx2G -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000

if [ -z "$1" ]
then
  TAG=v3
else
  TAG=$1
fi
docker build -t kinnaradigitalstudio/kecak-workflow:$TAG .
