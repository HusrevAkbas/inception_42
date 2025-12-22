FROM	alpine:3.21.5

COPY	./wordpress-6.8.3.tar.gz /tmp/wordpress.tar.gz

RUN		apk update; \
		apk add --no-cache php84 php84-mysqli php84-fpm curl sed; \
		mkdir -p /var/www/html; \
		tar -xzf /tmp/wordpress.tar.gz -C /tmp; \
		mv /tmp/wordpress/* /var/www/html/.

COPY	./tools/starter.sh ./starter.sh
COPY	./tools/install.php /var/www/html/wp-admin/install.php

RUN		chmod +x ./starter.sh;

EXPOSE	9000

ENTRYPOINT ["./starter.sh"]
