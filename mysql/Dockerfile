FROM	alpine

VOLUME	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add openrc mysql mysql-client --no-cache
RUN		openrc && touch /run/openrc/softlevel
RUN		adduser -D -g 'www' -h /home/www www

RUN		rc-update add mariadb default

COPY	srcs /home/www/

RUN		rc-service mariadb setup
RUN		rc-service mariadb restart && mysql -u root < "/home/www/mysql_secure_installation.sql"

RUN		rc-service mariadb restart

EXPOSE	3306
