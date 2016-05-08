#!/bin/bash
xtrace_orgin=$(set +o | grep xtrace)
set -o xtrace

# if using local repository, repository is empty
# if using remote repository, repository should like
# http://192.168.56.101/hcba_cloud
export repository=""
export db_host="127.0.0.1"
export db_port=3306
export db_name=hcbaweb
export db_username=hcbaweb
export db_password=passw0rd
export ftp_user=hcba_ftp
export ftp_password=passw0rd
export ftp_path=/home/hcba001
export r_num=3

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
configure_r $r_num

# update the mysql server
source utils/mysql
update_mysql_r_slave $db_host $db_name $db_username $db_password $ftp_user $ftp_password $ftp_path $r_num

# configure security
source utils/security
configure_security

${xtrace_origin}