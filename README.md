web/hcba_appstore
    war
        the current hcba appstore war
        the name must be "HCBA-APPSTORE.war"
    db
        the hcba appstore initial database script
	the script name must be "appstore.sql"
    other
	other configuration file related
web/hcba_web
    war
        the current hcba web war
        the name must be "HCBA-WEB.war"
    db
        the hcba web initial database script
	the script name must be "web.sql"
    other
	other configuration file related
web/jetty
    jetty related
    the jetty installation package
    the name must be "JETTY.tar.gz"
web/tomcat
    Apache tomcat server related
web/was
    IBM Websphere application server related

db/mysql
    mysql database related
db/db2
    IBM DB2 database related

dm/R
    the R installation package and Rserve package
    the R installation package must be "R.tar.gz"
    the Rserve package must be "Rserve.tar.gz"
dm/SPSS
	the spss related information
	
heat
    including the heat template that used to orchestrate openstack vm
    including the following heat template

rhel65
    base
        the content of RHEL6.5-20131111.0-Server-s390x-DVD1.iso
    supp
        the content of RHEL6.5-Supplementary-20131114.2-Server-s390x-DVD1.iso
    extras
        extra package that use in yum repository
