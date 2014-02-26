#/bin/bash

redis-server /opt/redis.conf && oauthd start > /dev/null 2>&1 && tail -f /usr/local/lib/node_modules/oauthd/out.log

