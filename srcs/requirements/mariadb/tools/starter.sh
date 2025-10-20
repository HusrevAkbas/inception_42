#!/bin/ash

echo "This is STARTER script"

#set -e

DATADIR=/var/lib/maria

signal_terminate_trap()
{
	mariadb-admin shutdown & wait $!
	echo "MariaDB shot down successfully"
}

trap "signal_terminate_trap" SIGTERM

if [ ! -f $DATADIR/ibdata1 ]; then

	# install db
	mariadb-install-db --user=mysql --datadir=$DATADIR\
		--auth-root-authentication-method=socket & wait $!

	# run DB with temporary socket
	mariadbd --datadir=$DATADIR --socket=/tmp/maria.sock & pid="$!"

	# wait until DB is ready
	for i in $(seq 1 30); do
		if mariadb-admin ping --socket=/tmp/maria.sock; then
			break ;
		fi
		sleep 1; echo "waiting for DB"
	done
	echo "DB is ready"

	# write SQL script to add users
	echo "CREATE DATABASE IF NOT EXISTS DBNAME;" > init.sql
	echo "CREATE USER 'DBUSER'@'%' IDENTIFIED BY 'DBPASS';" >> init.sql
	echo "GRANT ALL PRIVILEGES ON DBNAME.* TO 'DBUSER'@'%';" >> init.sql
	echo "FLUSH PRIVILEGES;" >> init.sql

	# add users with script
	mariadb --socket=/tmp/maria.sock < init.sql

	# exit temporary DB
	kill "$pid"
	wait "$pid"
fi

# run DB service
mariadbd --datadir=$DATADIR

# ready to use, enjoy
