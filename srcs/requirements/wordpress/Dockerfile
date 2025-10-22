FROM	alpine:3.21.5

RUN		apk update; apk add --no-cache php84 php84-fpm; ls wordpress-6.8.3.ta.gz || wget https://wordpress.org/wordpress-6.8.3.tar.gz; tar -xzf wordpress* wordpress; ls /etc/php*; cat /etc/php*/php.ini
COPY	./tools/starter.sh ./starter.sh

RUN	chmod +x ./starter.sh;
#mkdir -p /run/maria/ /run/secrets/; chmod 777 /run/maria/ /var/lib/mysql

ENTRYPOINT ["./starter.sh"]
