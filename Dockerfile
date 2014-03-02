FROM debian
MAINTAINER Dario Andrei <wouldgo84@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y wget curl python g++ make checkinstall tcl

RUN cd /tmp && wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make distclean && make && cd src/ && cp $(pwd)/redis-server /bin/redis-server && cp $(pwd)/redis-cli /bin/redis-cli

RUN src=$(mktemp -d) && cd $src && wget -N http://nodejs.org/dist/node-latest.tar.gz && tar xzvf node-latest.tar.gz && cd node-v* && ./configure && checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install && dpkg -i node_*

RUN cd /opt && npm install -g forever && npm install oauthd

RUN cp /tmp/redis-stable/redis.conf /opt/redis.conf
RUN sed -i -re"s/.*daemonize.*no/daemonize yes/g" /opt/redis.conf


RUN sed -i -re"s/host_url:.+/host_url: 'http:\/\/%DOMAIN_NAME%',/g" /opt/node_modules/oauthd/config.js
RUN sed -i -re"s/(.+)\/\/\s*bind:.+/\1bind: '0.0.0.0',/g" /opt/node_modules/oauthd/config.js
RUN sed -i -re"s/staticsalt:.*'.+'.*/staticsalt: '$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)',/g" /opt/node_modules/oauthd/config.js
RUN sed -i -re"s/publicsalt:.*'.+'.*/publicsalt: '$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)',/g" /opt/node_modules/oauthd/config.js

ADD ./startup.sh /opt/startup.sh

EXPOSE 6284
CMD ["/bin/bash", "/opt/startup.sh"]
