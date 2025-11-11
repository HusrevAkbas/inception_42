#!/bin/ash

echo "This is WORDPRESS script"

set -e

#signal_terminate_trap()
#{
#	mariadb-admin shutdown & wait $!
#	echo "MariaDB shot down successfully"
#	exit 0
#}

#trap "signal_terminate_trap" SIGTERM

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "wp-config.php NOT FOUND"
else
	cat /var/www/html/wp-config.php
fi

# -F: keeps php-fpm in foreground, -R force porgram run as root
php-fpm84 -F -R
