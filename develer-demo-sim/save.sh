#!/bin/bash

set -e -o xtrace

docker save develer/ros:humble | gzip > develer_ros_latest.tar.gz
docker save develer/node-ui | gzip > develer_node_ui_latest.tar.gz
