FROM nodesource/wheezy:5.9.0
MAINTAINER Dario Andrei <wouldgo84@gmail.com>

  RUN npm install -g oauthd@1.0.0-beta.23 grunt-cli

ADD ./run/bootstrap.sh /opt/bootstrap.sh

EXPOSE 6284
ENV NODE_ENV dev

CMD ["/bin/bash", "/opt/bootstrap.sh"]
