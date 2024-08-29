#!/bin/bash

set -e -o xtrace

zcat develer_ros_latest.tar.gz | docker load
zcat develer_node_ui_latest.tar.gz | docker load

