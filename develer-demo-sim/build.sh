#!/bin/bash

set -e

export XSOCK="/tmp/.X11-unix"

BASE_PATH="$(pwd)"
ROS_DISTRO="${ROS_DISTRO:-humble}"
VALKYRIE_SIM_PATH="./valkyrie-sim"
GRIMORIO_PATH="${VALKYRIE_SIM_PATH}/grimorio"
NODE_UI_PATH="./alto-robotics-node-ui"

[[ -d ${GRIMORIO_PATH} ]] && rm -rf ${GRIMORIO_PATH}
git clone git@github.com:AltoRobotics/grimorio.git ${GRIMORIO_PATH}

[[ -d ${NODE_UI_PATH} ]] && rm -rf ${NODE_UI_PATH}
git clone git@github.com:develersrl/alto-robotics-node-ui.git ${NODE_UI_PATH}
cd ${NODE_UI_PATH}/web
npm install
cd ..
cp .env.example .env
make backend-populate-db
make frontend-build
make backend-build
cp server ../go
cp db.sqlite ../go
cd ${BASE_PATH}

ROS_DISTRO=${ROS_DISTRO} docker compose build

rm -rf ${GRIMORIO_PATH}
rm -rf ${NODE_UI_PATH}
rm go/server
rm go/db.sqlite
