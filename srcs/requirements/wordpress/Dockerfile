FROM	alpine:3.21.5

#RUN		apk update; apk search php84*

RUN		apk update; apk add --no-cache php84 php84-mysqli php84-fpm curl sed && wget https://wordpress.org/wordpress-6.8.3.tar.gz && mkdir -p /var/www/html; tar -xzf wordpress* wordpress && mv wordpress/* /var/www/html/.

#ls /etc/php*; ls /usr/share/php84/

COPY	./tools/starter.sh ./starter.sh

RUN		chmod +x ./starter.sh;

#mkdir /etc/php84/php-fpm.d/wp.conf

EXPOSE	9000

ENTRYPOINT ["./starter.sh"]
