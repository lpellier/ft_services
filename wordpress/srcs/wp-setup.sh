echo "198.143.164.252 api.wordpress.org \
198.143.164.250 downloads.wordpress.org" >> /etc/hosts
mkdir /home/www/wordpress

wp core download --path=/home/www/wordpress --allow-root

wp config create \
--dbname=mysql-wp-db \
--dbuser=admin \
--dbpass=$WORDPRESS_DB_PASSWORD \
--dbhost=$WORDPRESS_DB_HOST \
--path=/home/www/wordpress/ \
--allow-root

wp core install \
--url=192.168.49.2:5050 \
--title=Example \
--admin_user=admin \
--admin_password=$WORDPRESS_DB_PASSWORD \
--admin_email=info@example.com \
--path=/home/www/wordpress/ \
--allow-root

chown -R www:www /home/www/wordpress

rc-service php-fpm7 restart && nginx -g "daemon off;"