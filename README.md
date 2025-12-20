*This project has been created as part of the 42 curriculum by huakbas*

# Description

In this project we create a Docker project as a web server. We have 3 containers for different services. We use docker network to connect containers to each other. We use docker volumes to keep and be available even if containers are stopped or recreated. NGINX is only entry point to whole service, so our database is also can not be reached from outside. 

### Container 1: NGINX

NGINX connects the world with my Wordpress web pages

### Container 2: Wordpress/PHP-FPM

PHP-FPM uses FastCGI to make data transfer faster.

### Container 3: Mariadb

Mariadb keeps all data used in Wordpress.

# Instructions

A Makefile is provided and you can execute several simple commands to manage the project.

**make** / **make up**  : This command starts project. If docker images are not present, images will be created, necessary files will be downloaded. Then all docker containers will be run.

**make down**   : This command stops working containers.

**make clean**  : This command removes previously used containers and images.

**make fclean** : This command removes containers, all images as well as database and wordpress files.

**make keygen** : If you don't have a SSL certificate, you can use this command to generate a self signed SSL certificate.

# Resources

Use the links to learn about: [Docker](https://docs.docker.com/), [PHP-FPM](https://www.php.net/manual/en/install.fpm.php), [MariaDB](https://mariadb.org/documentation/)

# Project Description

## Virtual Machines vs Docker

We use virtual machines and containers to isolate our applications. They have their own advantages. Containers are comes in handy when you need many application runs at the same time and they must communicate each other. There are main differences between VM and Docker

|   |**Virtual Machines**|**Docker Containers**
|---|---|---|
|**Technology**|Emulates as complete computer| OS level virtualization
|**Isolation**| Strong isolation|Shares OS kernel
|**Startup Time**|Longer startup time|Faster startup time
|**Portability**|Less portable|Highly portable, consistent across different platforms
|**Resource**|Use more resource|Requires less resource|
|**Maintenance**|Hard to manage. Every VM requires maintenance|Easy to maintain and update|
|**Security**|More secure because of isolation|More vulnerable to kernel level attacks|
|**Availability**|Ready-made VMs are difficult to find|Pre-built containers are easy to find|
|**Operating System**|Each VM has its own OS|Containers share host OS|
|**User Friendly**|VMs are easier to use|Difficult to use because of complex mechanism|

## Secrets vs Environment variables

### [About secrets](https://docs.docker.com/engine/swarm/secrets/)
In terms of Docker Swarm services, a secret is a blob of data, such as a password, SSH private key, SSL certificate, or another piece of data that should not be transmitted over a network or stored unencrypted in a Dockerfile or in your application's source code. You can use Docker secrets to centrally manage this data and securely transmit it to only those containers that need access to it. Secrets are encrypted during transit and at rest in a Docker swarm. A given secret is only accessible to those services which have been granted explicit access to it, and only while those service tasks are running.

You can use secrets to manage any sensitive data which a container needs at runtime but you don't want to store in the image or in source control, such as:
1. Usernames and passwords
2. TLS certificates and keys
3. SSH keys
4. Other important data such as the name of a database or internal server
5. Generic strings or binary content (up to 500 kb in size)

### About environment variables

Environment variables are accessible by all processes run in docker compose. It is vulnerable to attacks that expose environment variables.

## Docker network vs Host Network

Docker network is isolated.  Containers have private IP addresses. Port mapping allows multiple containers to use same port. Ports must be specified.Safer than using host network.

Host network option let docker use directly host network. In this case port mapping is not available. It can cause conflicts with host services. This option has better performance.

## Docker volumes vs Bind mounts

Docker volumes are managed by Docker. It is safer and more portable to use across different containers. Docker volumes has better performance on MacOS and Windows machines. 

You have direct file access while using bind mount. A specific path is mapped directly into a container. It is more useful for development. File changes are applied in both directions immediately.
