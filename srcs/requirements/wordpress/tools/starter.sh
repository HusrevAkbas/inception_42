#!/bin/ash

echo "This is WORDPRESS script"

CONFIG_FILE=/var/www/html/wp-config.php
INSTALL_FILE=/var/www/html/wp-admin/install.php
FUNCS_FILE=/var/www/html/wp-content/themes/twentytwentyfive/functions.php

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
	
	# set wp-config.php
	echo "<?php" > $CONFIG_FILE
	echo "define( 'DB_NAME', '$(cat /run/secrets/wp_dbname)' );" >> $CONFIG_FILE
	echo "define( 'DB_USER', '$(cat /run/secrets/db_username)' );" >> $CONFIG_FILE
	echo "define( 'DB_PASSWORD', '$(cat /run/secrets/db_password)' );" >> $CONFIG_FILE
	echo "define( 'DB_HOST', '$WORDPRESS_DB_HOST' );" >> $CONFIG_FILE
	echo "define( 'DB_CHARSET', 'utf8mb4' );" >> $CONFIG_FILE
	echo "define( 'DB_COLLATE', '' );" >> $CONFIG_FILE
	echo "define( 'WP_HOME', 'https://$DOMAIN_NAME');" >> $CONFIG_FILE
	echo "define( 'WP_SITEURL', 'https://$DOMAIN_NAME');" >> $CONFIG_FILE
	echo "$SALT" >> $CONFIG_FILE
	echo '$table_prefix'" = 'inception_';" >> $CONFIG_FILE
	echo "if ( ! defined( 'ABSPATH' ) ) { define( 'ABSPATH', __DIR__ . '/' ); }" >> $CONFIG_FILE
	echo "require_once ABSPATH . 'wp-settings.php';" >> $CONFIG_FILE

	# set variables in install.php
	echo $INSTALL_FILE > fileName
	sed -i "s/titleHere/Good One/" $INSTALL_FILE
	sed -i "s/adminnameHere/$(cat /run/secrets/wp_adminname)/" $INSTALL_FILE
	sed -i "s/adminpassHere/$(cat /run/secrets/wp_adminpass)/" $INSTALL_FILE
	sed -i "s/emailHere/$WP_ADMIN_EMAIL/" $INSTALL_FILE

	# add other user
	echo "function other_account(){" >> temp
	echo '$user = '"'$(cat /run/secrets/wp_username)';" >> temp
	echo '$pass = '"'$(cat /run/secrets/wp_userpass)';" >> temp
	echo '$email'" = '$WP_USER_EMAIL';" >> temp
	echo 'if ( !username_exists( $user ) && !email_exists( $email ) ) {' >> temp
	echo '$user_id = wp_create_user( $user, $pass, $email );' >> temp
	echo '$user = new WP_User( $user_id );' >> temp
	echo '$user'"->set_role( 'author' );" >> temp
	echo "} }" >> temp
	echo "add_action('init','other_account');">> temp
	cat temp >> $FUNCS_FILE
else
	echo "wp-config.php IS ALREADY EXIST $CONFIG_FILE"
fi

# -F: keeps php-fpm in foreground, -R force porgram run as root, exec makes php-fpm run as pid 1
exec php-fpm84 -F -R
