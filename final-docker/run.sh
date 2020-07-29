docker container run -it --net=host -e DISPLAY=$DISPLAY --volume=$HOME/.Xauthority:/root/.Xauthority:rw microservices-docker /bin/bash
# docker container run -dp 8080:8080 microservices-docker

