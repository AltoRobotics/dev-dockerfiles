#!/bin/bash
set -e

# setup ros2 environment
source /usr/share/gazebo/setup.bash
source /opt/ros/humble/setup.bash
source $ROS2_WS_ROOT/install/setup.bash

exec "$@"
