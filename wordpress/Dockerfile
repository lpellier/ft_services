FROM	alpine

VOLUME 	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add nginx openrc \
		php7 php7-fpm php7-common php7-iconv php7-json \
		php7-gd php7-curl php7-xml php7-mysqli php7-imap \
		php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-phar \
		php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-zlib \
		php7-ldap php7-ctype php7-dom curl php7-opcache --no-cache

RUN		openrc && touch /run/openrc/softlevel

RUN		adduser -D -g 'www' -h /home/www www
RUN		rc-update add nginx default
RUN		rc-update add php-fpm7 default

COPY 	/srcs /home/www
RUN		sh /home/www/nginx-setup.sh

RUN		rc-service nginx restart
RUN		rc-service php-fpm7 restart

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x /wp-cli.phar && mv /wp-cli.phar /usr/local/bin/wp
# RUN		cd /home/www && wp core download --allow-root

EXPOSE	5050 9000

# CMD		nginx -g "daemon off;"

# CURRENTLY NOT WORKING - NEEDS TO BE CONNECTED TO MYSQL DATABASE
# NEED TO START NGINX AND PHP AS CMD -- nginx -g "daemon off;"
