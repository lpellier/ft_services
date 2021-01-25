CREATE USER 'wp'@'%' IDENTIFIED BY 'pass';
CREATE USER 'wp'@'localhost' IDENTIFIED BY 'pass';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp'@'localhost' IDENTIFIED BY 'pass';
FLUSH PRIVILEGES;