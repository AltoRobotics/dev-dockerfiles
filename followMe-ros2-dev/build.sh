#!/bin/bash

git clone git@github.com:AltoRobotics/dotconfig.git  2>> /dev/null

docker build -t alto/ros:followMe-humble-dev .

rm -rf ./dotconfig
