FROM	alpine

VOLUME 	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add nginx openrc \
		php7-common php7-iconv php7-json \
		php7-gd php7-curl php7-xml php7-mysqli php7-imap \
		php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap \
		php7-xmlrpc php7-posix php7-mcrypt php7-gettext \
		php7-ldap php7-ctype php7-dom --no-cache

RUN		openrc && touch /run/openrc/softlevel

RUN		adduser -D -g 'www' -h /home/www www
RUN		rc-update add nginx default

COPY 	/srcs /home/www
RUN		sh /home/www/nginx-setup.sh

RUN		/etc/init.d/nginx restart

RUN		mkdir -p /usr/share/webapps/
RUN		cd /usr/share/webapps/
RUN		wgt http://wordpress.org/latest.tar.gz \
		&& tar -xzvf latest.tar.gz && rm latest.tar.gz

RUN		chown -R nginx /usr/share/webapps/
RUN		ln -s /usr/share/webapps/wordpress/ /home/www/wordpress

EXPOSE	5050

# CURRENTLY NOT WORKING - NEEDS TO BE CONNECTED TO DATABASE
