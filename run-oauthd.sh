#!/bin/bash

PWD=$(pwd)

docker run \
-name oauthd \
-d \
-h oauthd \
-p 127.0.0.1:6284:6284 \
-v $PWD/oauthd:/usr/local/lib/node_modules/oauthd \
wouldgo/oauthd
