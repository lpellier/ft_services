FROM	alpine

VOLUME 	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add --no-cache openrc php7\
		php7-session php7-fpm php7-common php7-iconv php7-json \
		php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-mbstring \
		php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-phar \
		php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-zlib \
		php7-ldap php7-ctype php7-dom curl php7-opcache mysql-client

RUN		adduser -D -g 'www' -h /home/www www
RUN sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = www|g" /etc/php7/php-fpm.d/www.conf
RUN sed -i "s|;listen.group\s*=\s*nobody|listen.group = www|g" /etc/php7/php-fpm.d/www.conf
RUN sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660|g" /etc/php7/php-fpm.d/www.conf
RUN sed -i "s|user\s*=\s*nobody|user = www|g" /etc/php7/php-fpm.d/www.conf
RUN sed -i "s|group\s*=\s*nobody|group = www|g" /etc/php7/php-fpm.d/www.conf
RUN sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf

RUN sed -i "s|display_errors\s*=\s*Off|display_errors = On|i" /etc/php7/php.ini
RUN sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = On|i" /etc/php7/php.ini
RUN sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR|i" /etc/php7/php.ini
RUN sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php7/php.ini
RUN sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = 50M|i" /etc/php7/php.ini
RUN sed -i "s|;*max_file_uploads =.*|max_file_uploads = 200|i" /etc/php7/php.ini
RUN sed -i "s|;*post_max_size =.*|post_max_size = 100M|i" /etc/php7/php.ini
RUN sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0 |i" /etc/php7/php.ini

RUN chown www:www -R /etc/php7
RUN chown www:www -R /var/log/php7

RUN		openrc && touch /run/openrc/softlevel



RUN		rc-update add php-fpm7 default

RUN		rc-service php-fpm7 restart
EXPOSE 9000
CMD php-fpm7 -F
