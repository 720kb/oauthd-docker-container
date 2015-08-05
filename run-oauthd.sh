#!/bin/bash

PWD=$(pwd)
DEFAULT_DOMAIN_NAME=localhost:6284 && \
read -p "Specify the machine hostname [$DEFAULT_DOMAIN_NAME]: " DOMAIN_NAME && \
DOMAIN_NAME=${DOMAIN_NAME:-$DEFAULT_DOMAIN_NAME} && \

docker run \
  --name oauthd \
  -d \
  -e "DOMAIN_NAME=$(echo $DOMAIN_NAME)" \
  -h oauthd \
  -p 127.0.0.1:6284:6284 \
  720kb/oauthd
