#!/bin/bash

redis-server /opt/redis.conf && \
sed -i -re"s/host_url:.+/host_url: 'http:\/\/$DOMAIN_NAME',/g" /usr/lib/node_modules/oauthd/config.js && \
sed -i -re"s/(.+)\/\/\s*bind:.+/\1bind: '0.0.0.0',/g" /usr/lib/node_modules/oauthd/config.js && \
sed -i -re"s/staticsalt:.*'.+'.*/staticsalt: '$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)',/g" /usr/lib/node_modules/oauthd/config.js && \
sed -i -re"s/publicsalt:.*'.+'.*/publicsalt: '$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)',/g" /usr/lib/node_modules/oauthd/config.js && \

sleep 1 && \
redis-cli ping && \

oauthd start && \
tail -f /usr/lib/node_modules/oauthd/forever.log /usr/lib/node_modules/oauthd/out.log /usr/lib/node_modules/oauthd/err.log
