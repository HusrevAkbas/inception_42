FROM	alpine:3.21.5

RUN	apk update; apk add --no-cache mariadb mariadb-client

COPY	./tools/starter.sh ./starter.sh

RUN	chmod +x ./starter.sh; mkdir -p /run/maria/ /run/secrets/; chmod 777 /run/maria/ /var/lib/mysql

EXPOSE	3306

ENTRYPOINT ["./starter.sh"]

