# Docker container for scalable JAVA stack and Microservices based applications

Project has been built and tested on an AWS EC2 ubuntu 18.04 machine sshed into from Arch Linux (Manjaro). The project aims at building a scalable JAVA stack using dockerised microservices.

# The project defines 4 microservices:
1. Spring-Boot with JAVA
2. MySQL
3. Tomcat
4. Eclipse IDE. 

**The docker containers can be made horizontally scalable with Docker Compose and fault-tolerant with Docker Swarm.**   
The project aims at easing JAVA stack development with the help of microservices. 

***The project suggests the use of an Xserver so that eclipse docker can be deployed***

# To deploy eclipse in the background along with tomcat: 
`docker run -d --net=host -e DISPLAY=$DISPLAY --volume=$HOME/.Xauthority:/root/.Xauthority:rw microservices-docker`  
  
# To deploy tomcat without eclipse:
`docker container run -dp 8080:8080 microservices-docker`

***Tomcat is always deployed as a foreground process***

Commands to run the dockerfile have been put in run.sh for your reference

# The docker-compose.dir directory
The docker-compose.dir directory includes the dockerfiles for 3 microservices; namely, **Spring-Boot**, **Eclipse IDE** and **Tomcat**. MySQL uses the official MySQL image.

Run the command `docker-compose up -d` to start the microservices. To know more about the services, take a look at the `docker-compose.yml` file  
Run the command `docker-compose down` to stop the services.  
Run the command `docker-compose up -d --scale "service-name"="x"` to start "x" containers of service "service-name"  
Run the command `docker-compose scale "service-name"="x"` to create total "x" containers of service "service-name"  

# Docker-Swarm
Take a look at the [official tutorial](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/) to create a swarm.  
In a nutshell:  

1. Create a manager node by sshing into it using `docker-machine ssh <manager-name>`  
2. Create a new swarm by `docker swarm init --advertise-addr <MANAGER-IP>`  
3. To add a worker node, use `docker swarm join --token=<MANAGER-TOKEN> <MANAGER-IP>:<PORT>`  



# Versions:
1. [Spring-Boot](https://github.com/spring-guides/gs-spring-boot):  2.3.2  
2. Tomcat: 9.0.37  
3. Java: openjdk-11  
4. [MySQL](https://github.com/docker-library/mysql/tree/master/5.7): 5.7  
