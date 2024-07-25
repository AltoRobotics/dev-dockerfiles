#!/bin/bash

set -e

export XSOCK="/tmp/.X11-unix"

ROS_DISTRO="${ROS_DISTRO:-humble}"
VALKYRIE_SIM_PATH="./valkyrie-sim"
GRIMORIO_PATH="${VALKYRIE_SIM_PATH}/grimorio"
ALTO_ROBOTICS_NODE_UI_BACKEND_PATH="./backend/code"
ALTO_ROBOTICS_NODE_UI_FRONTEND_PATH="./frontend/"

[[ -d ${GRIMORIO_PATH} ]] && rm -rf ${GRIMORIO_PATH}
git clone -b sb/websocket git@github.com:AltoRobotics/grimorio.git ${GRIMORIO_PATH}

[[ -d ${ALTO_ROBOTICS_NODE_UI_BACKEND_PATH} ]] && rm -rf ${ALTO_ROBOTICS_NODE_UI_BACKEND_PATH}
git clone git@github.com:develersrl/alto-robotics-node-ui.git ${ALTO_ROBOTICS_NODE_UI_BACKEND_PATH}

cp -rvf ${ALTO_ROBOTICS_NODE_UI_BACKEND_PATH}/web ${ALTO_ROBOTICS_NODE_UI_FRONTEND_PATH}
cp ${ALTO_ROBOTICS_NODE_UI_BACKEND_PATH}/.env.example ${ALTO_ROBOTICS_NODE_UI_FRONTEND_PATH}/web/.env

ROS_DISTRO=${ROS_DISTRO} docker compose build

rm -rf ${GRIMORIO_PATH}
rm -rf ${ALTO_ROBOTICS_NODE_UI_BACKEND_PATH}
rm -rf ${ALTO_ROBOTICS_NODE_UI_FRONTEND_PATH}/web
