# User Documentation

## Overview

This project provides Docker stack that includes several services, such as **NGINX**, **WordPress**, and **MariaDB**. These services work together to run a website with a content manager and a database.

## Services Provided

- **NGINX**: Acts as the web server and reverse proxy for the WordPress site.
- **WordPress**: Runs a FastCGI process manager for managing website content.
- **MariaDB**: The database that stores the WordPress data.

## Starting and Stopping the Project

To start the services:

1. Clone the repository.
2. Navigate to the project folder.
3. Run the following command to start all services:
   ```bash
   make
4. Run the following command to stop all services:
   ```bash
   make down
5. Run the following command to remove docker containers and docker images:
   ```bash
   make clean
6. Run the following command to remove all data including volumes, networks, database and WordPress files:
   ```bash
   make fclean
