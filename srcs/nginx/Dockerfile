FROM	alpine

VOLUME 	[ "/sys/fs/cgroup" ]

RUN	apk update && apk upgrade
RUN	apk add nginx openrc openssl --no-cache

RUN	mkdir -p /usr/share/webapps/

RUN	openrc && touch /run/openrc/softlevel

RUN	mkdir -p /etc/ssl/certs && mkdir -p /etc/ssl/private \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' -keyout \
	/etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

RUN	adduser -D -g 'www' -h /home/www www
RUN	chown -R www:www /etc/nginx
RUN	rc-update add nginx default

RUN	/etc/init.d/nginx restart

EXPOSE 	80 443

CMD	nginx -g "daemon off;"
