FROM	alpine

VOLUME	[ "/sys/fs/cgroup" ]

RUN	apk update && apk upgrade

RUN	apk add openrc mysql mysql-client --no-cache
RUN	openrc && touch /run/openrc/softlevel
RUN	adduser -D -g 'www' -h /home/www www

RUN	rc-update add mariadb default

ADD	./srcs/mysql_secure_installation.sql /home/www/
ADD	./srcs/create_pma_tables.sql /home/www/
ADD	./srcs/my.cnf /etc/my.cnf
ADD	./srcs/my.cnf /etc/mysql/my.cnf
ADD	./srcs/init.sh /init.sh

RUN 	addgroup mysql mysql

RUN 	mkdir /run/mysqld

EXPOSE	3306

CMD 	./init.sh
