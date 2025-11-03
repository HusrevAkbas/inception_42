#!/bin/ash

echo "This is STARTER script"

set -e

#DATADIR=/var/lib/mysql

#signal_terminate_trap()
#{
#	mariadb-admin shutdown & wait $!
#	echo "MariaDB shot down successfully"
#	exit 0
#}

#trap "signal_terminate_trap" SIGTERM

# -F: keeps php-fpm in foreground, -R force porgram run as root
php-fpm84 -F -R
