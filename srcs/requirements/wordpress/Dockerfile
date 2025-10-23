FROM	alpine:3.21.5

RUN		apk update; apk search php84*
RUN		apk update; apk add --no-cache php84 php84-mysqli php84-fpm; wget https://wordpress.org/wordpress-6.8.3.tar.gz; tar -xzf wordpress* wordpress; ls /etc/php*; cat /etc/php*/php.ini | grep path; ls /usr/share/php84/
COPY	./tools/starter.sh ./starter.sh

RUN		chmod +x ./starter.sh;
#mkdir -p /run/maria/ /run/secrets/; chmod 777 /run/maria/ /var/lib/mysql

ENTRYPOINT ["./starter.sh"]
