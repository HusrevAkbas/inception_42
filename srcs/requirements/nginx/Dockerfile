FROM	alpine:3.21.5

RUN	apk update; apk add --no-cache nginx

#COPY	./tools/starter.sh ./starter.sh

#RUN	chmod +x ./starter.sh;
#; mkdir -p /run/maria/ /run/secrets/; chmod 777 /run/maria/ /var/lib/mysql
# Include files with config snippets into the root context.
# include /etc/nginx/modules/*.conf;
# include /etc/nginx/conf.d/*.conf;
EXPOSE	80

#ENTRYPOINT ["./starter.sh"]

COPY	./conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

