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

ADD		./srcs /home/www

RUN		mv /home/www/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN		mv /home/www/vsftpd.userlist /etc/vsftpd/vsftpd.userlist

RUN		openrc && touch /run/openrc/softlevel

RUN		rc-update add vsftpd default
RUN		rc-service vsftpd restart

EXPOSE		20 21 30000-30010

#CMD		vsftpd /etc/vsftpd/vsftpd.conf
