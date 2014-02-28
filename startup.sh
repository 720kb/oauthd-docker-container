#!/bin/bash

redis-server /opt/redis.conf ; \
sleep 5 ; \
redis-cli ping ; \
cd /opt/node_modules/oauthd ; \
./oauthd.sh start ; tail -f out.log -f err.log
