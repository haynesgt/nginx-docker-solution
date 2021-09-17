#!/bin/bash
set -x
docker exec nginx nginx -s reload
