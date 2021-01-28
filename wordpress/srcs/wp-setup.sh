echo "198.143.164.252 api.wordpress.org \
198.143.164.250 downloads.wordpress.org" >> /etc/hosts
mkdir /home/www/wordpress

wp core download --path=/home/www/wordpress --allow-root

sleep 5

wp config create \
--dbname=wordpress \
--dbuser=wp \
--dbpass=pass \
--dbhost=mysql \
--path=/home/www/wordpress/ \
--allow-root

wp core install \
--url=192.168.49.2:30050 \
--title=Example \
--admin_user=wp \
--admin_password=pass \
--admin_email=info@example.com \
--path=/home/www/wordpress/ \
--allow-root

chown -R www:www /home/www/wordpress
chown -R www:www /home/www/nginx
rc-service php-fpm7 restart && nginx -g "daemon off;"
