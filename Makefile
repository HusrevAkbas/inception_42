LOGIN	=$(shell grep LOGIN srcs/.env | sed 's/LOGIN=//')

up:
	mkdir -p /home/$(LOGIN)/data/db/ /home/$(LOGIN)/data/wp/
#	chmod -R 774 /home/$(LOGIN)/data
	-docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

re: clean up

c: clean
clean: down
	-docker rm $(shell docker ps -aq)
	-docker rmi $(shell docker images -q)

f: fclean
fclean: down clean
	-docker volume rm $(shell docker volume ls -q)
	-docker system prune -af
	-sudo rm -rf /home/$(LOGIN)/data/
	
