#!/bin/bash

ROS_DISTRO="${ROS_DISTRO:-foxy}"

git clone git@github.com:AltoRobotics/dotconfig.git  2>> /dev/null

docker build -t alto/ros:${ROS_DISTRO}-husky-dev \
    --build-arg ros_distro=${ROS_DISTRO} .

rm -rf ./dotconfig
