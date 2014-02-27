#!/bin/bash

PWD=$(pwd)

docker run \
-name oauthd \
-d \
-h oauthd \
-p 127.0.0.1:6284:6284 \
wouldgo/oauthd
