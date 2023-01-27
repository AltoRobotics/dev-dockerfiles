#!/bin/bash

ROS_DISTRO="${ROS_DISTRO:-humble}"
SSH_PRIVATE_KEY=${HOME}/.ssh/id_rsa

DOCKER_BUILDKIT=1 docker build -t alto/ros:${ROS_DISTRO}-dev \
    --build-arg ros_distro=${ROS_DISTRO} \
    --secret id=ssh_id,src=${SSH_PRIVATE_KEY} .
