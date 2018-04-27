# Docker tasks

## Install Docker
[Download Docker for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)

[Download Docker for Ubuntu](https://store.docker.com/editions/community/docker-ce-server-ubuntu)

## First steps

### Run hello-world
`docker run --rm hello-world`

### Deploy a more complex Wordpress example with just docker
[MySQL Image](https://hub.docker.com/_/mysql/)
[Wordpress Image](https://hub.docker.com/_/wordpress/)

Let's pull the neccessary images:

`docker pull mysql`

`docker pull wordpress`

We need those containers running and knowing each other.

Start MySQL:

`docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql`

Then start Wordpress with linking to MySQL container:

`docker run --name some-wordpress --link some-mysql:mysql -d wordpress`

### Investigate a running container
`docker exec -it <container-name> <command>`

Dive right into wordpress container:

`docker exec -it some-wordpress bash`

### Stopping the wordpress container

`docker stop some-wordpress`

`docker rm some-wordpress``

### Exposing the http port 

`docker run --name some-wordpress --link some-mysql:mysql -p 80:80 -d wordpress`

### Open the browser

[http://localhost](http://localhost)

## Lifecycle stuff

### Stopping the containers

`docker stop some-wordpres`

`docker stop some-mysql`

### Starting the containers again

`docker start some-mysql`

`docker start some-wordpress`

### Removing the containers

`docker rm some-mysql`

### Rerunning MySQL and Wordpress shows that all persistent data has gone

## Working with volume mappings

`mkdir -p ./data/{mysql,wordpress}`

Starting the containers now with volume mapping:

`docker run --name some-mysql -v $(pwd)/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql`

`docker run --name some-wordpress -v $(pwd)/data/wordpress:/var/www/html --link some-mysql:mysql -p 80:80 -d wordpress`

