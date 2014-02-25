FROM debian
MAINTAINER Dario Andrei <wouldgo84@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y wget curl python g++ make checkinstall tcl

RUN cd /tmp && wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make distclean && make && cd src/ && ln -s $(pwd)/redis-server /bin/redis-server && ln -s $(pwd)/redis-cli /bin/redis-cli

RUN src=$(mktemp -d) && cd $src && wget -N http://nodejs.org/dist/node-latest.tar.gz && tar xzvf node-latest.tar.gz && cd node-v* && ./configure && checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install && sudo dpkg -i node_*

RUN npm install -g forever oauthd

CMD ["sh", "-c", "redis-server && oauthd config && oauthd start && tail -f /var/log/boot"]
