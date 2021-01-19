echo "198.143.164.252 api.wordpress.org \
198.143.164.250 downloads.wordpress.org" >> /etc/hosts
mkdir /home/www/wordpress
wp core download --path=/home/www/wordpress --allow-root
wp config create --dbname=mysql-wp-db --dbuser=admin --dbuser=pass --dbhost=mysql --path=/home/www/wordpress/ --url=127.0.0.1:5050 --allow-root
wp core install --url=127.0.0.1:5050 --title=Example --admin_user=admin --admin_password=pass --admin_email=info@example.com --path=/home/www/wordpress/ --allow-root

nginx -g "daemon off;" && rc-service php-fpm7 restart