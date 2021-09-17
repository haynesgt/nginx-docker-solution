#!/bin/bash
set -x

SOURCE=${BASH_SOURCE[0]}
SOURCE_DIR=$(realpath $(dirname "$SOURCE"))

source $SOURCE_DIR/env.sh

docker run --rm --detach --name nginx --net=host \
  -v $SOURCE_DIR/log:/var/log/nginx/ \
  -v $SOURCE_DIR/html:/usr/share/nginx/html \
  -v $SOURCE_DIR/etc:/etc/nginx \
  nginx:${NGINX_VERSION-latest}

