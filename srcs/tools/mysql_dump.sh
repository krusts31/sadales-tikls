#!/bin/sh
set -ex

if [ $# -lt 3 ]; then
  echo "Usage: $0 <host> <database> <password>"
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t mariadb_client $DIR

CONTAINER_NAME=$(docker ps -aqf "name=mariadb")

NAME=$(date +'dump_%y.%m.%d-%H.%M.%S'.sql)

HOST=$(cat $DIR/../.env-prod | grep $1 | cut -d '=' -f 2)
DATABASE=$(cat $DIR/../.env-prod | grep $2 | cut -d '=' -f 2)
PASSWORD=$(cat $DIR/../.env-prod | grep $3 | cut -d '=' -f 2-)

docker run --network=store-net --rm \
  -e MARAIDB_HOST=$HOST \
  -e USER=root \
  -e DATABASE=$DATABASE \
  -e PASSWORD=$PASSWORD \
  mariadb_client > /tmp/$NAME
