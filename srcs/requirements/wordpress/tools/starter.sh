#!/bin/ash

echo "This is WORDPRESS script"

CONFIG_FILE=/var/www/html/wp-config.php
INSTALL_FILE=/var/www/html/wp-admin/install.php

echo "Filename: $INSTALL_FILE"

#echo "config file: $CONFIG_FILE"
#echo "db name is $(cat /run/secrets/db_dbname)"
#ECHO "HOST: $WORDPRESS_DB_HOST"

set -e

#signal_terminate_trap()
#{
#	mariadb-admin shutdown & wait $!
#	echo "MariaDB shot down successfully"
#	exit 0
#}

#trap "signal_terminate_trap" SIGTERM

if [[ ! -f $CONFIG_FILE ]] || [[ ! -s $CONFIG_FILE ]]; then
	# download authentication keys
	SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
	echo "<?php" > $CONFIG_FILE
	echo "define( 'DB_NAME', '$(cat /run/secrets/db_dbname)' );" >> $CONFIG_FILE
	echo "define( 'DB_USER', '$(cat /run/secrets/db_adminname)' );" >> $CONFIG_FILE
	echo "define( 'DB_PASSWORD', '$(cat /run/secrets/db_adminpass)' );" >> $CONFIG_FILE
	echo "define( 'DB_HOST', '$WORDPRESS_DB_HOST' );" >> $CONFIG_FILE
	echo "define( 'DB_CHARSET', 'utf8mb4' );" >> $CONFIG_FILE
	echo "define( 'DB_COLLATE', '' );" >> $CONFIG_FILE
	echo "define( 'WP_HOME', 'https://huakbas.42.fr');" >> $CONFIG_FILE
	echo "define( 'WP_SITEURL', 'https://huakbas.42.fr');" >> $CONFIG_FILE
	echo "$SALT" >> $CONFIG_FILE
	echo '$table_prefix'" = 'wp_';" >> $CONFIG_FILE
	echo "if ( ! defined( 'ABSPATH' ) ) { define( 'ABSPATH', __DIR__ . '/' ); }" >> $CONFIG_FILE
	echo "require_once ABSPATH . 'wp-settings.php';" >> $CONFIG_FILE
	# set variables in install.php
	echo $INSTALL_FILE > fileName
	sed -i "s/titleHere/Good One/" $INSTALL_FILE
	sed -i "s/adminnameHere/$(cat /run/secrets/db_adminname)/" $INSTALL_FILE
	sed -i "s/adminpassHere/$(cat /run/secrets/db_adminpass)/" $INSTALL_FILE
	sed -i "s/emailHere/huakbas@42vienna.com/" $INSTALL_FILE
	cat $INSTALL_FILE
#	echo "wp-config.php NOT FOUND"
else
	echo "wp-config.php IS ALREADY EXIST $CONFIG_FILE"
	cat $CONFIG_FILE
fi

# -F: keeps php-fpm in foreground, -R force porgram run as root
php-fpm84 -F -R
