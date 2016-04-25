#!/bin/bash

xtrace_orgin=$(set +o | grep xtrace)
set -o xtrace

export repository=""
export local_ip=$(ifconfig eth0 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
export db_host=$local_ip
export db_port=3306
export db_root_password=passw0rd
export hcbaweb_db_name=hcbaweb
export hcbaweb_db_username=hcbaweb
export hcbaweb_db_password=passw0rd
export appstore_db_name=appstore
export appstore_db_username=appstore
export appstore_db_password=passw0rd
export ftp_user=hcba_ftp
export ftp_password=passw0rd
export ftp_path=/home/hcba001
export hcbaweb_url="http://$local_ip:8080/hcbaweb"

###################################################################################
###  hcbaweb configuration                                                      ###
###################################################################################

# get or set the current repository if null
if [ -z "$repository" ]; then
    export repository=$(cd $(dirname "$0")/.. && pwd)
fi

# create the hcba yum repo
source utils/repo
configure_repo

yum -y install wget

# install ftp server
source utils/ftp
configure_ftp

# install R
source utils/R
configure_r

# install the mysql server
source utils/mysql
configure_mysql_hcbaweb $db_root_password $hcbaweb_db_name $hcbaweb_db_username $hcbaweb_db_password $local_ip $ftp_user $ftp_password $ftp_path

# install jave
source utils/java
configure_openjdk_java

# configure jetty
source utils/jetty
configure_jetty
configure_jetty_hcbaweb


###################################################################################
###  appstore configuration                                                     ###
###################################################################################

# install mysql server
source utils/mysql
configure_mysql_appstore $db_root_password $appstore_db_name $appstore_db_username $appstore_db_password

# configure jetty
source utils/jetty
configure_jetty_appstore
clean_jetty

# configure security
source utils/security
configure_security

${xtrace_origin}