# Creating and running an image
docker build -t aabounak .
docker run -it -p 80:80 aabounak
docker start {CONTAINER ID}
docker exec -it {CONTAINER ID} bash

# Step 1: Installing the Nginx Web server
apt-get update
apt-get upgrade

apt-get install -y nginx

# Run the Nginx service
service nginx start [ ok ]

# Installing wget
apt-get install -y wget

# Installing VIM
apt-get update
apt-get install -y vim

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
service mysql start
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
vi config.inc.php
# We start by generating a blowfish secret and update the secret in the configuration file.
# phpsolved.com/phpmyadmin-blowfish-secret-generator/?g=5cecac771c51c
# Then we uncomment the phpMyAdmin storage settings
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

# Step 6.2: Installing Additional PHP Extensions
apt update
apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
service php7.3-fpm restart

# Step 6.3: Configuring Nginx
vi /etc/nginx/sites-available/default
