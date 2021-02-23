#!/bin/sh

if [ -z "$1" ]
then
  TAG=v3
else
  TAG=$1
fi
docker build -t kinnaradigitalstudio/kecak-workflow:$TAG .
