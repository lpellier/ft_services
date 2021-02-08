#!/bin/sh

if [ ! -d /usr/share/webapps/phpmyadmin/tmp ]; 
then
	apk add phpmyadmin
	cat /etc/config.inc.php > /etc/phpmyadmin/config.inc.php
	chown -R www:www /etc/phpmyadmin
	mkdir /usr/share/webapps/phpmyadmin/tmp
	chown -R www:www /usr/share/webapps/phpmyadmin
	chmod 777 /usr/share/webapps/phpmyadmin/tmp
else
	mkdir /etc/phpmyadmin
	cat /etc/config.inc.php > /etc/phpmyadmin/config.inc.php
	chown -R www:www /etc/phpmyadmin
fi

php-fpm7 -F
