#!/usr/bin/env bash

# Expose the X server on the host.
# Fast and loose version, requires user to have sudo privileges
# Also requires nvidia-container-toolkit to be installed

X11_SOCKET=/tmp/.X11-unix

sudo xhost +local:root
# --rm: Make the container ephemeral (delete on exit).
# -it: Interactive TTY.
# --gpus all: Make nVidia card visible in the docker container

docker run \
  --rm \
  -v $X11_SOCKET:$X11_SOCKET \
  --device /dev/dri \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  --gpus all \
  glvnd-x:nvidia_discrete \
  nvidia-smi && glmark2

sudo xhost -local:root
