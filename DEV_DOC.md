# Developer Documentation

This guide explains how to set up the development environment, build and run the project using Docker, manage containers/volumes, and store project data.

## Prerequisites

- **Docker**: Install [Docker and docker-compose](https://www.docker.com/products/docker-desktop).
- **Make**: Install [Make](https://www.gnu.org/software/make/).

## Environment Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repository/inception.git
   
2. Change directory into project directory

3. Provide following secret files in secrets/ folder:
	- ssl.key
	- ssl.crt
	- db_username.txt
	- db_password.txt
	- wp_db_name.txt
	- wp_admin_name.txt
	- wp_admin_password.txt
	- wp_user_name.txt
	- wp_user_password.txt

4. If you don't have a certificate or key, use **'make keygen'** command to generate a self signed SSL certificate

5. Provide a **.env** file in **srcs/** folder with following keys
	- LOGIN=
	- DOMAIN_NAME=
	- WP_ADMIN_EMAIL=
	- WP_USER_EMAIL=

## Manage project with Makefile commands

1. Run command to start project:
    ```bash
    make up

2. Run command to stop containers project:
    ```bash
    make down

3. Run command to remove containers and images:
    ```bash
    make clean

4. Run command to remove containers, images, database and wordpress files:
    ```bash
    make fclean

5. Run command to generate SSL certificate and key:
    ```bash
    make keygen

## Common Docker commands to manage containers

1. List containers
    ```bash
    docker ps

2. List images
    ```bash
    docker images

3. Access a container
    ```bash
    docker exec -it <container name> ash

4. List volumes
    ```bash
    docker volume ls

5. Inspect a volume
    ```
    docker volume inspect <volume name>

6. List networks
    ```bash
    docker network ls

7. Inspect a network
    ```bash
    docker network inspect <network name>

## Data storage

`LOGIN` is the value provided in **.env** file

1. Database is mount on /home/`LOGIN`/data/db
2. Wordpress is mount on /home/`LOGIN`/data/wp

