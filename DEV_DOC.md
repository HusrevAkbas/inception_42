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

6. Run command to start project:
    ```bash
    make up

