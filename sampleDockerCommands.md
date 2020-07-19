# Run the following command to start Chrome browser inside Docker

`run -it --net host --cpuset-cpus 0 --memory 512mb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=host.docker.internal:0  --privileged --name chrome jess/chrome`

# Run the following command to start Eclipse inside Docker

`
docker run -ti --rm \
           -e DISPLAY=host.docker.internal:0 \
           --net host --cpuset-cpus 0 --memory 512mb \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v "`pwd`":/workspace \
           fgrehm/eclipse:v4.4.1
`
