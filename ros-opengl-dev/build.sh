#!/bin/bash

ROS_DISTRO="${ROS_DISTRO:-humble}"

git clone git@github.com:AltoRobotics/dotconfig.git  2>> /dev/null

docker build -t alto/ros:${ROS_DISTRO}-dev \
    --build-arg ros_distro=${ROS_DISTRO} .

rm -rf ./dotconfig
