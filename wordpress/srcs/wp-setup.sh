echo "198.143.164.252 api.wordpress.org \
	198.143.164.250 downloads.wordpress.org" >> /etc/hosts

if [ ! -f /home/www/wordpress/wp-config.php ];
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

	wp core install \
		--url=192.168.49.2:30050 \
		--title=Example \
		--admin_user=wp \
		--admin_password=pass \
		--admin_email=info@example.com \
		--path=/home/www/wordpress/ \
		--allow-root
	
	wp user create bob bob@example.com
	wp user create jpp jpp@example.com
	chown -R www:www /home/www/wordpress
fi
php-fpm7 -F
