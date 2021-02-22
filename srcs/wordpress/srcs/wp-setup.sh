echo "198.143.164.252 api.wordpress.org \
	198.143.164.250 downloads.wordpress.org" >> /etc/hosts

sleep 15

if [ ! -f /home/www/wordpress/wp-config.php ]
then
	wp core download --path=/home/www/wordpress --allow-root
	sleep 5
	wp config create \
		--dbname=wordpress \
		--dbuser=wp \
		--dbpass=pass \
		--dbhost=mysql \
		--path=/home/www/wordpress/ \
		--allow-root

fi
wp core install \
	--url=192.168.49.24:5050 \
	--title=Example \
	--admin_user=wp \
	--admin_password=pass \
	--admin_email=info@example.com \
	--path=/home/www/wordpress/ \
	--allow-root
wp user create bob bob@example.com --role=author --user_pass=pass --path=/home/www/wordpress --allow-root
wp user create jpp jpp@example.com --role=author --user_pass=pass --path=/home/www/wordpress --allow-root
chown -R www:www /home/www/wordpress
php-fpm7 -F
