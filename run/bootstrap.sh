#!/bin/bash

redis-server /opt/redis.conf && \
oauthd init --default && \
mv default-oauthd-instance oauthd-instance && \
cd oauthd-instance && \
sed -i -re"s/host_url:.+/host_url: 'http:\/\/$DOMAIN_NAME',/g" config.js && \
sed -i -re"s/(.+)\/\/\s*bind:.+/\1bind: '0.0.0.0',/g" config.js && \
sed -i -re"s/staticsalt:.*'.+'.*/staticsalt: '$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)',/g" config.js && \
sed -i -re"s/publicsalt:.*'.+'.*/publicsalt: '$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)',/g" config.js && \

sleep 5 && \
redis-cli ping && \

oauthd start
