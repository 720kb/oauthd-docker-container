#!/bin/bash

echo "Give me the domain name..."
read DOMAIN_NAME

sed -i -re"s/%DOMAIN_NAME%/$DOMAIN_NAME/" Dockerfile

docker build -rm=true -t wouldgo/oauthd .

