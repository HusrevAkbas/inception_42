#!/bin/ash

echo "This is NGINX script"

set -e


signal_terminate_trap()+
{
	# gracefully exit nginx
	nginx -s quit & wait $!
	exit 0
}

trap "signal_terminate_trap" SIGTERM

exec nginx -g 'daemon off;'

# ready to use, enjoy
