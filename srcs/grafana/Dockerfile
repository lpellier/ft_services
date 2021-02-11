FROM alpine

VOLUME [ "/sys/fs/cgroup" ]

RUN apk update && apk upgrade

ADD srcs ./

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk add --no-cache openrc grafana 

RUN mkdir /etc/grafana
RUN mv grafana.ini /etc/grafana/grafana.ini

RUN openrc && touch /run/openrc/softlevel

EXPOSE 3000

CMD grafana-server -config=/etc/grafana/grafana.ini -homepath=/usr/share/grafana/
