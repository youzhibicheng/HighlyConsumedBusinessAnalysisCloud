#!/bin/bash

xtrace_orgin=$(set +o | grep xtrace)
set -o xtrace

export repository=""
export db_host=127.0.0.1
export db_port=3306
export db_root_password=passw0rd
export db_name=hcbaweb
export db_username=hcbaweb
export db_password=passw0rd
export r_ip=127.0.0.1
export ftp_user=hcba_ftp
export ftp_password=passw0rd
export ftp_path=/home/hcba001

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
r_ip=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
configure_mysql_hcbaweb $db_root_password $db_name $db_username $db_password $r_ip $ftp_user $ftp_password $ftp_path

# install jave
source utils/java
configure_openjdk_java

# configure jetty
source utils/jetty
configure_jetty
configure_jetty_hcbaweb
clean_jetty

# configure security
source utils/security
configure_security

${xtrace_origin}
