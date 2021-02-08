FROM		alpine

VOLUME 		[ "/sys/fs/cgroup" ]


RUN		apk update && apk upgrade

RUN		adduser -D -g 'www' -h /home/www www
RUN 		passwd www -d 'pass'

RUN		apk add openrc vsftpd --no-cache

ADD		./srcs /home/www

RUN		mv /home/www/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN		mv /home/www/vsftpd.userlist /etc/vsftpd/vsftpd.userlist

RUN		openrc && touch /run/openrc/softlevel

RUN		rc-update add vsftpd default
RUN		rc-service vsftpd restart

EXPOSE		20 21

CMD		vsftpd /etc/vsftpd/vsftpd.conf
