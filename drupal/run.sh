#!/bin/sh
docker rmi `docker images |grep neibrs/drupal |awk '{print $3}'`
docker build -t --no-cache neibrs/drupal . && \
docker push neibrs/drupal
