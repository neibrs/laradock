#!/bin/sh

docker pull neibrs/drupal

docker rm -f drupal
docker run -d --name drupal neibrs/drupal
if [ -d ../drupal.old ]; then
  rm -rf ../drupal.old
fi
if [ -d ../drupal ]; then
  mv ../drupal ../drupal.old
fi
docker cp drupal:/var/www/html ../drupal
docker stop drupal
docker rm drupal
