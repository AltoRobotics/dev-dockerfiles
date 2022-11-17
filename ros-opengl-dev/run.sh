#!/usr/bin/env bash

# ====================================
# Run command. Verify if the xauth file exists or if a container with the same
# name is already running.
# ====================================

if (( "$#" < 1 || "$#" > 2 ))
then
    echo "Illegal number of parameters. Usage: run.sh <container-id> [image-name]"
    echo "Example: run.sh ros-container"
    exit 1
fi

# ====================================
# Specify some variables that are useful while setting up the container
# ====================================

CONTAINERNAME=${1:-"ros-container"}
IMAGENAME=${2:-"alto/ros:melodic-dev"}
XSOCK="/tmp/.X11-unix"

# ====================================
# With two arguments, the user wants an already existing container.
# With three, a new one must be spawned
# Create the proper container name according to whether it exists or not
# ====================================

if [ "$#" -eq 1 ]
then
    NEW_CONTAINER="false"
    if [ ! "$(docker ps -a | grep $CONTAINERNAME)" ]
    then
        echo "Container $CONTAINERNAME does not exist. No action performed."
        exit 1
    fi
else
    NEW_CONTAINER="true"
    if [ "$(docker ps -a | grep $CONTAINERNAME)" ]
    then
        TIMESTAMP=`date +"%y_%m_%d-%k_%M_%S"`
        echo "Container $CONTAINERNAME already exists. Adding timestamp $TIMESTAMP."
        CONTAINERNAME=$CONTAINERNAME-$TIMESTAMP
    fi
fi

echo "Running container $CONTAINERNAME"

# ====================================
# Add --network=host and --privileged if connecting to other ROS nodes
# Add --volume=<host-volume>:<mount-point> for sharing the host filesystem
# Add --gpus all: Make nVidia card visible in the docker container
# ====================================

if [ ! "$(docker ps -a | grep $CONTAINERNAME)" ]
then
    sudo xhost +local:root
    docker run \
        -it \
        --name=$CONTAINERNAME \
        -e DISPLAY \
        -e QT_X11_NO_MITSHM=1 \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=/dev:/dev/ \
        --device /dev/dri \
        --privileged \
        $IMAGENAME
    sudo xhost -local:root
else
    docker start $CONTAINERNAME > /dev/null
    docker exec -it $CONTAINERNAME bash
fi


