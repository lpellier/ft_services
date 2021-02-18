FROM		alpine

VOLUME 		[ "/sys/fs/cgroup" ]


RUN		apk update && apk upgrade

RUN		adduser -D -g 'www' -h /home/www www
RUN 		passwd www -d 'pass'

RUN		apk add openrc openssl vsftpd --no-cache

RUN             mkdir -p /etc/ssl/certs && mkdir -p /etc/ssl/private \
                && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
                -subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' -keyout \
                /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

ADD		./srcs / 

RUN		chmod 755 /home
RUN		chmod 755 /home/www

RUN		mv /test.txt /home/www

RUN		openrc && touch /run/openrc/softlevel

RUN		rc-update add vsftpd default
RUN		rc-service vsftpd restart

EXPOSE		20 21 30100-30104

CMD		sh vsftpd-setup.sh
