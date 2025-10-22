#!/bin/ash

echo "This is STARTER script"

set -e

DATADIR=/var/lib/mysql

signal_terminate_trap()
{
	mariadb-admin shutdown & wait $!
	echo "MariaDB shot down successfully"
	exit 0
}

trap "signal_terminate_trap" SIGTERM

#exec /var/sbin/php-fpm8.4
