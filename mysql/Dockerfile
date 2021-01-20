FROM	alpine

VOLUME	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add openrc mysql mysql-client --no-cache
RUN		openrc && touch /run/openrc/softlevel
RUN		adduser -D -g 'www' -h /home/www www

RUN		rc-update add mariadb default

COPY	srcs /home/www/

RUN 	mysql_install_db --user=root --datadir=/var/lib/mysql
RUN 	cp -f /home/www/my.cnf /etc/mysql/my.cnf

RUN		rc-service mariadb start && mysql -u root < "/home/www/mysql_secure_installation.sql"

EXPOSE	3306

CMD 	/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --console & wait
