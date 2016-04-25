#!/bin/bash

# get the current path
TOP_DIR=$(cd $(dirname "$0") && pwd)

# create the /etc/yum.repo.d/hcba.repo in host
cat /dev/null > /etc/yum.repos.d/hcba.repo
echo "[base]" >> /etc/yum.repos.d/hcba.repo
echo "name=hcba-base" >> /etc/yum.repos.d/hcba.repo
echo "baseurl=file://$TOP_DIR/rhel65/base" >> /etc/yum.repos.d/hcba.repo
echo "enabled=1" >> /etc/yum.repos.d/hcba.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/hcba.repo

echo "[supp]" >> /etc/yum.repos.d/hcba.repo
echo "name=hcba-supp" >> /etc/yum.repos.d/hcba.repo
echo "baseurl=file://$TOP_DIR/rhel65/supp" >> /etc/yum.repos.d/hcba.repo
echo "enabled=1" >> /etc/yum.repos.d/hcba.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/hcba.repo

echo "[extras]" >> /etc/yum.repos.d/hcba.repo
echo "name=hcba-extras" >> /etc/yum.repos.d/hcba.repo
echo "baseurl=file://$TOP_DIR/rhel65/extras" >> /etc/yum.repos.d/hcba.repo
echo "enabled=1" >> /etc/yum.repos.d/hcba.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/hcba.repo

yum clean all

yum -y install httpd
chkconfig httpd on

echo "<Directory \"$TOP_DIR\">" >> /etc/httpd/conf/httpd.conf
echo "    Options Indexes FollowSymLinks" >> /etc/httpd/conf/httpd.conf
echo "    AllowOverride None" >> /etc/httpd/conf/httpd.conf
echo "    Order allow,deny" >> /etc/httpd/conf/httpd.conf
echo "    Allow from all" >> /etc/httpd/conf/httpd.conf
echo "</Directory>" >> /etc/httpd/conf/httpd.conf

service httpd start

# ln -s /var/www/html/hcba_cloud to the current hcba_cloud directory
chown -R 755 $TOP_DIR
ln -s $TOP_DIR /var/www/html/hcba_cloud 

# to backup
#cd $TOP_DIR/../
#tar -zcvf hcba_cloud_01_x86_64.tar.gz hcba_cloud --exclude hcba_cloud/rhel65
#tar -zcvf hcba_cloud_02_x86_64.tar.gz hcba_cloud/rhel65/base/*
#tar -zcvf hcba_cloud_03_x86_64.tar.gz hcba_cloud/rhel65/supp/* hcba_cloud/rhel65/extras/*

#tar -zcvf hcba_cloud_01_s390.tar.gz hcba_cloud --exclude hcba_cloud/rhel65
#tar -zcvf hcba_cloud_02_s390.tar.gz hcba_cloud/rhel65/base/*
#tar -zcvf hcba_cloud_03_s390.tar.gz hcba_cloud/rhel65/supp/* hcba_cloud/rhel65/extras/*

