# Running Wordpress Blog with docker-compose

## Docker Compose

Let's write a docker-compose.yml for our wordpress blog

### Basic parts

services:

```{yaml}
version: '3'
services:
  wordpress:
  mysql:
```

All services

```{yaml}
version: '3'
services:
  wordpress:
    image: wordpress
    ports:
      - 80:80
    environment:
      - WORDPRESS_DB_NAME=blog
      - WORDPRESS_DB_HOST=mysql
      - WORDPRESS_DB_PASSWORD=my-secret-pw
    volumes:
      - ./data/wordpress:/var/www/html
    depends_on:
      - mysql
    restart: always

  mysql:
    image: mysql
    ports:
     - 3306:3306
    environment:
      - MYSQL_ROOT_PASSWORD=my-secret-pw
    volumes:
      - ./data/mysql:/var/lib/mysql
    restart: always
```

### Starting that thing

`docker-compose up`

### Stopping 

`CTRL-C`

### Run in daemon mode

`docker-compose up -d`

### Access into the container

`docker-compose exec wordpress bash`

### Destroy that thing

`docker-compose down`