#!/bin/bash

git clone git@github.com:AltoRobotics/dotconfig.git  2>> /dev/null

docker build -t alto/ros-humble:followMe-dev .

rm -rf ./dotconfig
