# Creating and running an image
docker build -t aabounak .
docker run -it -p 80:80 aabounak
docker start {CONTAINER ID}
docker exec -it {CONTAINER ID} bash

# Step 1: Installing the Nginx Web server & wget & Vim
apt-get update
apt-get upgrade

apt-get install -y nginx wget vim

# Step 2: Installing MySQL Database
apt update
apt install -y gnupg lsb-release

cd /tmp
export DEBIAN_FRONTEND=noninteractive
echo "mysql-apt-config mysql-apt-config/select-server select mysql-5.7" | debconf-set-selections
wget http://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
dpkg -i mysql-apt-config_0.8.13-1_all.deb
apt update
apt install -y mysql-server

# Starting Nginx and MySQL
mysql_secure_installation	# This script will take you through a series of prompts

# Step 3: Installing PHP7.3 and related packages
apt install -y php7.3-fpm php7.3-cli php7.3-common php7.3-curl php7.3-gd php7.3-mbstring php7.3-mysql php7.3-xml php7.3-xmlrpc php7.3-zip

# Step 4: Install and Configure phpMyAdmin
cd /var/www/html
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.zip
apt install zip unzip -y
unzip phpMyAdmin-4.9.0.1-english.zip
cd phpMyAdmin-4.9.0.1-english/
mv * /var/www/html/
cd ..
rm phpMyAdmin-4.9.0.1-english.zip
rm -rf phpMyAdmin-4.9.0.1-english/

mkdir tmp
chmod 777 tmp/
mv config.sample.inc.php config.inc.php
# vi config.inc.php
# We start by generating a blowfish secret and update the secret in the configuration file.
# phpsolved.com/phpmyadmin-blowfish-secret-generator/?g=5cecac771c51c
# Then we uncomment the phpMyAdmin storage settings

mkdir phpmyadmin
mv * /var/www/html/phpmyadmin
cd phpmyadmin
mv index.nginx-debian.html ../

mysql < sql/create_tables.sql	# Create the tables that don't exist yet in the database
mysql
GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'pmapass';
GRANT ALL ON *.* TO 'aabounak'@'localhost' IDENTIFIED BY 'aabounak' WITH GRANT OPTION;
exit

# Step 5: Configure Nginx for phpMyAdmin
vi /etc/nginx/sites-available/default
# Add index.php
# Uncomment --> location ~ \.php$ {
#	include snippets/fastcgi-php.conf;
#	fastcgi_pass unix:/run/php/php7.3-fpm.sock;
# }

service nginx restart
service mysql restart
service php7.3-fpm start

# Step 6: Install WordPress with LEMP

# Step 6.1: Creating a MySQL Database and User for WordPress
mysql -u root -p
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;	# DB that WordPress can control
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'aabounak';
FLUSH PRIVILEGES;
EXIT;

# Step 6.2: Installing Additional PHP Extensions
apt update
apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
service php7.3-fpm restart

# Step 6.3: Configuring Nginx
# vi /etc/nginx/sites-available/default
# server {
# 	location = /favicon.ico { log_not_found off; access_log off; }
# 	location = /robots.txt { log_not_found off; access_log off; allow all; }
#	location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
#		expires max;
#		log_not_found off;
#		}
# }

# server {
# 	location / {
	#try_files $uri $uri/ =404;
#	try_files $uri $uri/ /index.php$is_args$args;
#	}
# }

nginx -t
service nginx restart

# Step 7: Downloading Wordpress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
cp -a /tmp/wordpress/. /var/www/html
chown -R www-data:www-data /var/www/html

# Step 8: Setting up the WordPress Configuration File
wget https://api.wordpress.org/secret-key/1.1/salt/
# cat index.html
# vi /var/www/html/wp-config.php	# Paste

# ...
# define('DB_NAME', 'wordpress');
# /** MySQL database username */
# define('DB_USER', 'wordpress_user');
# /** MySQL database password */
# define('DB_PASSWORD', 'password');
# ...
# define('FS_METHOD', 'direct');

# Step 9: Completing the Installation Through the Web Interface
# 127.0.0.1
# Tests
# 127.0.0.1/phpmyadmin
# username: wordpress_user
# password: aabounak
