LOGIN	=$(shell grep LOGIN srcs/.env | sed 's/LOGIN=//')
SECRETS_DIR = secrets
SECRET_FILES= db_password.txt ssl.key wp_db_name.txt db_username.txt\
	wp_admin_name.txt wp_user_name.txt ssl.crt wp_admin_password.txt\
	wp_user_password.txt
SECRETS=$(addprefix $(SECRETS_DIR)/, $(SECRET_FILES))
DOTENV_FILE = ./srcs/.env
REQUIRED_VARIABLES = LOGIN DOMAIN_NAME WP_ADMIN_EMAIL WP_USER_EMAIL

up: check-secrets check-dotenv check-deps
	-docker-compose -f ./srcs/docker-compose.yml up -d

check-deps:
	mkdir -p /home/$(LOGIN)/data/db/ /home/$(LOGIN)/data/wp/
	@if [ ! -s srcs/requirements/wordpress/wordpress-6.8.3.tar.gz ]; then \
		wget -O srcs/requirements/wordpress/wordpress-6.8.3.tar.gz https://wordpress.org/wordpress-6.8.3.tar.gz; \
	fi

check-secrets:
	@if [ ! -d secrets ]; then \
		echo "Secret files must be provided in 'secrets' directory" ;\
		exit 1 ;\
	fi
	@for f in $(SECRETS); do \
		if [ ! -s $$f ]; then \
			echo "File is missing: \e[1;31m$$f\e[0m"; \
			echo "If ssl.crt or ssl.key is missing, generate one using 'make keygen' command";\
			exit 1;\
		fi; \
	done
	@echo "All secret files are present"

check-dotenv:
	@if [ ! -f $(DOTENV_FILE) ]; then \
		echo "$(DOTENV_FILE) file must be provided"; \
		exit 1; \
	fi
	@for v in $(REQUIRED_VARIABLES); do \
		if ! grep -qE "^$${v}" $(DOTENV_FILE); then \
			echo "Missing $$v in $(DOTENV_FILE)"; \
			exit 1; \
		fi \
	done
	@echo "All .env variables are present"

keygen:
	mkdir -p $(SECRETS_DIR)
	openssl req \
		-newkey rsa:4096 -nodes -keyout $(SECRETS_DIR)/ssl.key \
		-x509 -config srcs/crt.conf -sha256 -days 365 \
		-out $(SECRETS_DIR)/ssl.crt

down:
	docker-compose -f ./srcs/docker-compose.yml down

re: clean up

c: clean
clean: down
	-docker rm $(shell docker ps -aq)
	-docker image rm $(shell docker images -aq)

f: fclean
fclean: down clean
	-docker volume rm $(shell docker volume ls -q)
	-docker system prune -af
	-sudo rm -rf /home/$(LOGIN)/data/

.PHONY: up down re c clean f fclean check-secrets check-dotenv keygen check-deps
