FROM	alpine:3.21.5

RUN		apk update; apk add --no-cache nginx;

EXPOSE	443

COPY	./conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD		["nginx", "-g", "daemon off;"]

