# What is DevShop?

DevShop is open source cloud hosting system for Drupal.

This container launches the Devmaster front-end control panel for devshop.

# How to use this image?

## Manual Launch

## Manual launch:

    $ docker run --name database -d -e MYSQL_ROOT_PASSWORD=12345 mariadb 
    $ docker run --name hostmaster --hostname aegir.local.computer -e MYSQL_ROOT_PASSWORD=12345 --link database:mysql -p 80:80 aegir/hostmaster
    
## docker-compose launch:

  1. Create a docker-compose.yml file:

    ```
    version: '2'
    services:
    
      hostmaster:
        image: devshop/devmaster
        ports:
          - 80:80
        hostname: devmaster.local.computer
        links:
          - database
        depends_on:
          - database
        environment:
          MYSQL_ROOT_PASSWORD: strongpassword

      database:
        image: mariadb
        environment:
          MYSQL_ROOT_PASSWORD: strongpassword
    ```
  2. run `docker-compose up`.
  
## Important parts:

  - MYSQL_ROOT_PASSWORD: 12345.  This must match for database and hostmaster containers.  If launching in production, choose a secure password.
  - --hostname devmaster.local.computer.  The hostname of the container must be set to a fully qualified domain that resolves to the host machine.  *.local.computer resolves to 127.0.0.1, so it is useful to use for launching locally.
  - -p 80:80.  Since this one container is going to host numerous websites for you, it expects to be assigned to port 80 (unless you are hooking up another container like varnish or a load balancer on the same machine.)
