FROM	alpine

VOLUME	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		mkdir -p /usr/share/webapps/

RUN 	cd /usr/share/webapps && wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN		tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && rm phpMyAdmin-5.0.2-all-languages.tar.gz

RUN		mv phpMyAdmin-5.0.2-all-languages phpmyadmin

RUN		chmod -R 777 /usr/share/webapps

RUN		ln -s /usr/share/webapps/phpmyadmin/ /home/www/phpmyadmin

EXPOSE	5000