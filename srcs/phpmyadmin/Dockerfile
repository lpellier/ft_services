FROM php-fpm7

RUN		apk update && apk upgrade


COPY srcs/pma-setup.sh /


EXPOSE	5000

CMD		chmod +x /pma-setup.sh && ./pma-setup.sh
