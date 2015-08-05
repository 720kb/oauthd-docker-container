FROM debian
MAINTAINER Dario Andrei <wouldgo84@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y wget curl build-essential tcl git
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash - && apt-get install -y nodejs

RUN cd /tmp && wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make distclean && make && cd src/ && cp $(pwd)/redis-server /bin/redis-server && cp $(pwd)/redis-cli /bin/redis-cli
RUN cp /tmp/redis-stable/redis.conf /opt/redis.conf
RUN sed -i -re"s/.*daemonize.*no/daemonize yes/g" /opt/redis.conf

RUN npm install -g oauthd@1.0.0-beta.16 grunt-cli

ADD ./run/bootstrap.sh /opt/bootstrap.sh

EXPOSE 6284
CMD ["/bin/bash", "/opt/bootstrap.sh"]
