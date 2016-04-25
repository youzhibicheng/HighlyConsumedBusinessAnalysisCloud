#!/bin/bash
xtrace_orgin=$(set +o | grep xtrace)
set -o xtrace

export repository=""
export db_host=127.0.0.1
export db_port=3306
export db_root_password=passw0rd
export db_name=appstore
export db_username=appstore
export db_password=passw0rd

# get or set the current repository if null
if [ -z "$repository" ]; then
    export repository=$(cd $(dirname "$0")/.. && pwd)
fi

# create the hcba yum repo
source utils/repo
configure_repo

yum -y install wget

# install mysql server
source utils/mysql
configure_mysql_appstore $db_root_password $db_name $db_username $db_password


# install java
source utils/java
configure_openjdk_java

# configure jetty
source utils/jetty
configure_jetty
configure_jetty_appstore

# configure security
source utils/security
configure_security

${xtrace_origin}