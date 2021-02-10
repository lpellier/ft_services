FROM alpine

VOLUME [ "/sys/fs/cgroup" ]

RUN apk update && apk upgrade

RUN apk add --no-cache openrc influxdb

RUN adduser -D -g 'www' -h /home/www www

RUN openrc && touch /run/openrc/softlevel

RUN rc-update add influxdb default

RUN rc-service influxdb restart

EXPOSE 8086
