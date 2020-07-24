docker container run --rm --net=host -e DISPLAY=$DISPLAY -it --volume=$HOME/.Xauthority:/root/.Xauthority:rw -p 8080:8080 microservices-docker
