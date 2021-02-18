sleep 10

mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
mysqld_safe --user=root &

sleep 2

mysql < /home/www/create_pma_tables.sql && \
mysql < /home/www/mysql_secure_installation.sql

wait %+
