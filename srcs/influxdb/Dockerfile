FROM alpine

VOLUME [ "/sys/fs/cgroup" ]

RUN apk update && apk upgrade

ADD srcs ./

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk add --no-cache openrc influxdb telegraf

RUN openrc && touch /run/openrc/softlevel

RUN rc-update add influxdb default
RUN rc-update add telegraf default

RUN mkdir /etc/influxdb
RUN mv influxdb.conf /etc/influxdb/influxdb.conf

RUN mkdir /etc/telegraf
RUN mv telegraf.conf /etc/telegraf/telegraf.conf

RUN rc-service influxdb restart
RUN rc-service telegraf restart

RUN export INFLUXDB_CONFIG_PATH=/etc/influxdb/influxdb.conf

RUN chmod +x init.sh

EXPOSE 8086

CMD ./init.sh
