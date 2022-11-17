#!/bin/bash

ROS_DISTRO="${ROS_DISTRO:-melodic}"

docker build -t alto/ros:${ROS_DISTRO}-dev --build-arg ros_distro=${ROS_DISTRO} .

