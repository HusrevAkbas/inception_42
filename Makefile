up:
	mkdir -p /home/huakbas/data/db/ /home/huakbas/data/wp/
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down

re: clean up

c: clean
clean:
	-docker rm $(shell docker ps -aq)
	-docker rmi $(shell docker images -q)

f: fclean
fclean: clean
	docker volume rm $(shell docker volume ls -q)
	docker system prune -af
	rm -rf /home/huakbas/data/*
