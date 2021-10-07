#!/bin/bash
set -x

SOURCE=${BASH_SOURCE[0]}
SOURCE_DIR=$(realpath $(dirname "$SOURCE"))

source $SOURCE_DIR/env.sh

docker stop nginx 2> /dev/null
docker rm nginx 2> /dev/null

git update-index --assume-unchanged log/ log/*
# undo: git update-index --no-assume-unchanged log/ log/*

docker run --detach --name nginx --net=host \
  --restart=always \
  -v $SOURCE_DIR/log:/var/log/nginx/ \
  -v $SOURCE_DIR/html:/usr/share/nginx/html \
  -v $SOURCE_DIR/etc:/etc/nginx \
  nginx:${NGINX_VERSION-latest}
