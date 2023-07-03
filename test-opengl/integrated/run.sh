#!/usr/bin/env bash

# Expose the X server on the host.
# Fast and loose version, requires user to have sudo privileges

X11_SOCKET=/tmp/.X11-unix

sudo xhost +local:root
# --rm: Make the container ephemeral (delete on exit).
# -it: Interactive TTY.

docker run \
  --rm \
  -v $X11_SOCKET:$X11_SOCKET \
  --device /dev/dri \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  glvnd-x:integrated \
  bash -c "glmark2"

sudo xhost -local:root
