#!/bin/bash

v="$1"

[ -z "$v" ] && echo "Provide version of tomcat" && exit 1

# download and setup tomcat in /opt/
tomcat_ver="apache-tomcat-${v}"
tomcat_url="http://apache.mirror.anlx.net/tomcat/tomcat-9/v${v}/bin/${tomcat_ver}.tar.gz"
wget -qO- $tomcat_url | tar -C /opt/ -zxvf-

tomcat_dir="/opt/$tomcat_ver"

if [ ! -d ${tomcat_dir} ]; then
  echo "Tomcat directory ($tomcat_dir) does not exist! exiting...."
  exit 1
fi

app_user="devops"
useradd $app_user

company_war="https://s3.amazonaws.com/infra-assessment/companyNews.war"
wget -q -O $tomcat_dir/webapps/companyNews.war $company_war

# switch users to $app_user
chown -R $app_user: $tomcat_dir

# hack - companyWar seems to want persistence files in /Users/dcameron :)
mkdir -p /Users/dcameron/persistence && chown -R $app_user: /Users

# start tomcat
su - devops -c "$tomcat_dir/bin/startup.sh"
