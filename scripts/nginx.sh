#!/bin/bash

# setup web stuff
cnews_dir="/usr/share/nginx/html/companyNews"
mkdir $cnews_dir
static_url="https://s3.amazonaws.com/infra-assessment/static.zip"
wget -qO /tmp/static.zip $static_url && unzip -od /tmp/ /tmp/static.zip && \
rsync -auz /tmp/static/* $cnews_dir/

# copy config
#cp files/nginx.conf /etc/nginx/nginx.conf
#cp file/tomcat.conf /etc/nginx/conf.d/

service nginx start
sleep 5
curl http://localhost/index.html

exit $?
