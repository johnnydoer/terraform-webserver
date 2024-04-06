#!/bin/bash
# Install Apache Web Server
yum install -y httpd
# Turn on web server
chkconfig httpd on
service httpd start
# Download and extract files
wget https://denizyilmaz-ce3.s3.eu-west-2.amazonaws.com/startbootstrap.zip
unzip startbootstrap.zip -d /var/www/html/
mv /var/www/html/startbootstrap/* /var/www/html/
rm -rf /var/www/html/startbootstrap/