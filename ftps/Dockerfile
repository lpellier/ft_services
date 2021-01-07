FROM	alpine

VOLUME 	[ "/sys/fs/cgroup" ]

RUN		apk update && apk upgrade

RUN		apk add openrc vsftpd --no-cache

RUN		openrc && touch /run/openrc/softlevel

RUN		rc-update add vsftpd default
RUN		rc-service vsftpd restart

EXPOSE	21