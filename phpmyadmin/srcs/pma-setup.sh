#!/bin/sh

#VOLUMES ARE SET UP
#NOW ADAPT DOCKERFILE TO REMOVE NGINX
#CREATE TMP FOLDER IN PMA ONCE POD RUNNING
#GIVE RIGHTS TO WWW ON /ETC/PHPMYADMIN && TMP FOLDER
#MIGHT WANT TO SEPARATE PHP-FPM7 ONCE EVERYTHING'S WORKING

if [ ! -d /usr/share/webapps/phpmyadmin/tmp ] 
then
	apk add phpmyadmin
	cat /etc/config.inc.php > /etc/phpmyadmin/config.inc.php
	chown -R www:www /etc/phpmyadmin
	mkdir /usr/share/webapps/phpmyadmin/tmp
	chown -R www:www /usr/share/webapps/phpmyadmin
	chmod 777 /usr/share/webapps/phpmyadmin/tmp
fi

php-fpm7 -F
