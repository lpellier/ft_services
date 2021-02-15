FROM	php-fpm7

RUN	apk update && apk upgrade

RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x /wp-cli.phar && mv /wp-cli.phar /usr/local/bin/wp

ADD 	./srcs/wp-setup.sh ./wp-setup.sh

EXPOSE	5050 9000

CMD 	sh	./wp-setup.sh
