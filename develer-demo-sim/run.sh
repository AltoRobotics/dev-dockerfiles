#!/usr/bin/env bash

# ====================================
# Run command. Verify if the xauth file exists or if a container with the same
# name is already running.
# ====================================

if (( "$#" < 1 || "$#" > 3 ))
then
    echo "Illegal number of parameters. Usage: run.sh <container-id> [image-name] [mount volume]"
    echo "Example: run.sh ros-container ros_ws_path"
    exit 1
fi

# ====================================
# Specify some variables that are useful while setting up the container
# ====================================

CONTAINERNAME=${1}
IMAGENAME=${2}
MOUNT_VOLUME=${3}
XSOCK="/tmp/.X11-unix"

# ====================================
# With one argument, the user wants an already existing container.
# With two, a new one must be spawned
# With three, the user also wants to mount a volume in the container
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

# ====================================
# Add --network=host and --privileged if connecting to other ROS nodes
# Add --volume=<host-volume>:<mount-point> for sharing the host filesystem
# Add --gpus all: Make nVidia card visible in the docker container
# ====================================

echo "Running container $CONTAINERNAME"

if [ "${3}" ]
then
    MOUNTING_VOLUME="--volume=$(realpath ${3}):/host"
    echo "Mounting volume ${3} into /host"
else
    MOUNTING_VOLUME=""
fi

sudo xhost +local:root

if [ ! "$(docker ps -a | grep $CONTAINERNAME)" ]
then
    docker run \
        -it \
        --name=$CONTAINERNAME \
        -e DISPLAY \
        -e QT_X11_NO_MITSHM=1 \
        -e WAYLAND_DISPLAY \
        -e XDG_RUNTIME_DIR \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=${HOME}/.ssh:${HOME}/.ssh:ro \
        --volume=/dev:/dev/ \
        ${MOUNTING_VOLUME} \
        --device=/dev/dri \
        --device /dev/ttyACM0 \
        --privileged \
	    --network=host \
        $IMAGENAME \
        ros2 launch valkyrie_bringup valkyrie_bringup_sim.launch.py launch_teleop:=false use_sim:=true
else
    docker start $CONTAINERNAME > /dev/null
    docker exec -it $CONTAINERNAME bash
fi
