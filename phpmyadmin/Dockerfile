FROM	alpine

VOLUME	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add openrc \
			php7 php7-fpm php7-common php7-iconv php7-json \
			php7-gd php7-curl php7-xml php7-mysqli php7-imap \
			php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-phar \
 			php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-zlib \
			php7-ldap php7-ctype php7-dom curl php7-opcache mysql-client --no-cache

RUN   adduser -D -g 'www' -h /home/www www

COPY srcs/pma-setup.sh /

RUN   openrc && touch /run/openrc/softlevel

RUN		rc-update add php-fpm7 default

RUN		rc-service php-fpm7 restart

EXPOSE	5000

CMD		chmod +x /pma-setup.sh && ./pma-setup.sh
