FROM 	alpine

VOLUME [ "/sys/fs/cgroup/" ]

RUN 	apk update
RUN		apk add --no-cache nginx openrc openssl openssh
RUN		adduser -D www

RUN		mkdir -p /etc/ssl/certs && mkdir -p /etc/ssl/private \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' -keyout \
		/etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

COPY	index.html styles images /var/www/
RUN		openrc && touch /run/openrc/softlevel
RUN		rc-update add nginx default
RUN		rc-service nginx restart

RUN 	nginx -t

EXPOSE	80 443 22

CMD		rc-service sshd restart && nginx -g 'pid /tmp/nginx.pid; daemon off;'