#!/bin/bash

ROS_DISTRO="${ROS_DISTRO:-humble}"

git clone git@github.com:AltoRobotics/grimorio.git

docker build -t develer/ros:${ROS_DISTRO} \
    --build-arg ros_distro=${ROS_DISTRO} .

rm -rf grimorio
