FROM debian:buster


ADD srcs /srcs
RUN cd /
RUN sh /srcs/script.sh
CMD chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && service mysql start && service nginx start && service php7.3-fpm start ; cat
