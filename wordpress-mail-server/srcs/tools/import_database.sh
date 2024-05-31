#!/bin/sh
set -ex

CONTAINER_NAME=$(docker ps -aqf "name=wordpress")

docker cp $1 $CONTAINER_NAME:/var/www/wordpress/$1

docker exec $CONTAINER_NAME wp db import $1
