ARG ros_distro=humble
ARG from=osrf/ros:${ros_distro}-desktop
FROM ${from}

# Set up localization

RUN apt update && \
    apt install -y locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

# Fetch dependencies and packages

RUN apt update && \
    apt -y install --no-install-recommends gperf x11-apps glmark2 \
    ccache curl tmux wget can-utils  \
    python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file gdb htop \
    libsdl2-dev libmagic1 sudo udev libncursesw5-dev openocd usbutils vim python2

# Install some ROS packages that might not be installed by default

RUN apt update && \
    apt install -y ros-dev-tools ros-humble-rosbridge-server \
    ros-humble-plotjuggler-ros ros-humble-joint-state-publisher-gui \
    ros-humble-rqt-joint-trajectory-controller ros-humble-gazebo-ros-pkgs \
    ros-humble-ros2-control ros-humble-ros2-controllers \
    ros-humble-gazebo-ros2-control

# Install some python related non-default dependencies

RUN pip3 install  numpy==1.25.2 scipy==1.11.3 numpy-quaternion

# Set up environment variables

ENV ROS2_WS_ROOT="/workspace/ros2_ws"

# Set up ROS2 workspace in the image

COPY ./grimorio /workspace
RUN cd ${ROS2_WS_ROOT} && \
    . /opt/ros/${ROS_DISTRO}/setup.sh && \
    rosdep install -y --from-paths src --ignore-src && \
    colcon build

# Set up Starship

RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    echo '\neval "$(starship init bash)"\n' >> /root/.bashrc

# Set up ros workspace

RUN echo '\nsource $ROS2_WS_ROOT/install/setup.bash\n' >> /root/.bashrc

# Show shell at startup

# CMD ["ros2 launch valkyrie_bringup valkyrie_bringup_sim.launch.py launch_teleop:=false use_sim:=true"]
CMD ["bash"]
