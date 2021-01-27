FROM	alpine

VOLUME	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add nginx openrc phpmyadmin \
			php7 php7-fpm php7-common php7-iconv php7-json \
			php7-gd php7-curl php7-xml php7-mysqli php7-imap \
			php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-phar \
 			php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-zlib \
			php7-ldap php7-ctype php7-dom curl php7-opcache mysql-client --no-cache

RUN   adduser -D -g 'www' -h /home/www www
RUN 	chown -R www:www /etc/phpmyadmin

COPY 	srcs /home/www
RUN		cp /home/www/nginx.conf /etc/nginx/
RUN		chown -R www:www /etc/nginx

RUN   wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN   tar zxvf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN   rm phpMyAdmin-5.0.4-all-languages.tar.gz
RUN   mv phpMyAdmin-5.0.4-all-languages phpmyadmin
RUN   mv phpmyadmin /home/www/

RUN		cp -f /home/www/config.inc.php /etc/phpmyadmin/

RUN   openrc && touch /run/openrc/softlevel

RUN   rc-update add nginx default
RUN		rc-update add php-fpm7 default

RUN		nginx -t
RUN		rc-service php-fpm7 restart
RUN		rc-service nginx restart

EXPOSE	5000
