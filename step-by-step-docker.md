# Step By Step

## Docker

## Installation

[Install for Mac: https://docs.docker.com/docker-for-mac/install/](https://docs.docker.com/docker-for-mac/install/)
[Install for Ubuntu: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
[Install for CentOS: https://docs.docker.com/engine/installation/linux/docker-ce/centos/](https://docs.docker.com/engine/installation/linux/docker-ce/centos/)

## Basics

### Docker commands

`docker version`

`docker ps`

`docker images`

`docker run | start | stop | kill`

`docker pull`

`docker push`

## Tasks

## Install mysql

[Docker HUB: https://hub.docker.com/_/wordpress/](https://hub.docker.com/_/mysql/)

`docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql`

`docker ps`

## Install Wordpress

[Docker HUB Wordpress: https://hub.docker.com/_/wordpress/](https://hub.docker.com/_/wordpress/)

`docker run --name some-wordpress -p 81:80 --link some-mysql:mysql -d wordpress`

`docker ps`

## Open Wordpress

[http://localhost:81](http://localhost:81)

## Configure and play with it

## Stop and restart mysql and wordpress

### Stop

`docker stop some-wordpress`

`docker stop some-mysql`

### Start

`docker start some-mysql`

`docker start some-wordpress`

## Remove mysql and wordpress

`docker kill some-mysql`

`docker kill some-wordpress`

`docker rm some-mysql`

`docker rm some-wordpress`

## Rerun MySQL and Wordpress

Have a look at what happens and think about it.

## Creating Volume mappings

`mkdir -p data/{mysql,wordpress}`

## Starting with mappings

`docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -v $(pwd)/data/mysql:/var/lib/mysql -d mysql`

`docker run --name some-wordpress -p 81:80 --link some-mysql:mysql -v $(pwd)/data/wordpress:/var/www/html -d wordpress`

## Open in Browser

[http://localhost:81](http://localhost:81)

## Destroy and remove containers

`docker kill some-mysql`

`docker kill some-wordpress`

`docker rm some-mysql`

`docker rm some-wordpress`

## Rerun MySQL and Wordpress

`docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -v $(pwd)/data/mysql:/var/lib/mysql -d mysql`

`docker run --name some-wordpress -p 81:80 --link some-mysql:mysql -v $(pwd)/data/wordpress:/var/www/html -d wordpress`

## Open in Browser

[http://localhost:81](http://localhost:81)

# Docker Machine

## Setup local docker-machine

[Setup docker-machine with xhyve](https://allysonjulian.com/posts/setting-up-docker-with-xhyve/)

### For Macos

`docker-machine create dev --driver xhyve --xhyve-experimental-nfs-share`

## Setup DigitalOcean

`docker-machine create --driver digitalocean --digitalocean-access-token $DIGITALOCEAN_TOKEN demo`

## Select new machine

`eval $(docker-machine env demo)`

## Play with MySQL and Wordpress

`docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -v $(pwd)/data/mysql:/var/lib/mysql -d mysql`

`docker run --name some-wordpress -p 81:80 --link some-mysql:mysql -v $(pwd)/data/wordpress:/var/www/html -d wordpress`

## Destroy docker-machine

`docker-machine rm demo`

# Docker Compose

## Create a docker-compose.yml

```(yaml)
version: '3'
services:
  wordpress:
    image: wordpress
    ports:
      - 80:80
    environment:
      - MYSQL_ROOT_PASSWORD=my-secret-pw
    volumes:
      - ./data/wordpress:/var/www/html
    depends_on:
      - mysql
  
  mysql:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=my-secret-pw
    volumes:
      - ./data/mysql:/var/lib/mysql
    
```

## Run the stack

`docker-compose up`

# Dockerfile

## Create a Dockerfile

[Create a Dockerfile for MongoDB](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images)

## Short demo

```(Dockerfile)
############################################################
# Dockerfile to build MongoDB container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Example McAuthor

# Update the repository sources list
RUN apt-get update

################## BEGIN INSTALLATION ######################
# Install MongoDB Following the Instructions at MongoDB Docs
# Ref: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Add the package verification key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# Add MongoDB to the repository sources list
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# Update the repository sources list once more
RUN apt-get update

# Install MongoDB package (.deb)
RUN apt-get install -y mongodb-10gen

# Create the default data directory
RUN mkdir -p /data/db

##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 27017

# Default port to execute the entrypoint (MongoDB)
CMD ["--port 27017"]

# Set default container command
ENTRYPOINT usr/bin/mongod
```

## Build the image

`docker build -f Dockerfile-mongodb -t puredelight/mongodb:latest .`

## Login

`docker login`

## docker push

`docker push puredelight/mongodb:latest`

## Run Mongodb

`docker run --rm -p 27017:27017 puredelight/mongodb:latest`

## Open Studio 3T

Connect to local Mongodb
