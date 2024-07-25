#!/bin/bash

set -e

echo export XSOCK="/tmp/.X11-unix" > .env_vars
source .env_vars

ROS_DISTRO="${ROS_DISTRO:-humble}" docker compose up -d

sleep 3

xdg-open http://127.0.0.1:3000 &
