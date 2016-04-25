#!/bin/bash
xtrace_orgin=$(set +o | grep xtrace)
set -o xtrace

export repository=""
export db_host=127.0.0.1
export db_port=3306
export db_name=hcbaweb
export db_username=hcbaweb
export db_password=passw0rd
export ftp_host=127.0.0.1
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

# update the mysql server
source utils/mysql
update_mysql_r_slave $db_host $db_name $db_username $db_password $ftp_user $ftp_password $ftp_path

# configure security
source utils/security
configure_security

${xtrace_origin}