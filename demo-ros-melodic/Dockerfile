ARG from=alto/ros:melodic-dev
FROM ${from}

# Set up noninteractive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install librealsense
RUN apt update &&  apt install -y -qq --no-install-recommends \
    libssl-dev \
    libusb-1.0-0-dev \
    libudev-dev \
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    at \
    udev && \
    rm -rf /var/lib/apt/lists/* && \
    cd root && \
    git clone https://github.com/IntelRealSense/librealsense.git && \
    mkdir -p /etc/udev/rules.d && \
    cd librealsense/ && \
    ./scripts/setup_udev_rules.sh && \
    mkdir build && cd build && \
    cmake ../ -DCMAKE_BUILD_TYPE=Release && \
    sudo make uninstall && make clean && make -j10 && sudo make install

# Install Python3.8 and make it default for python3
RUN apt update && apt install -y -qq \
    python3.8-dev && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    pip3 install --upgrade pip

# Install compatible cv_bridge for python3.8 and ROS1
## The /bin/bash -c format is needed to overcome an issue with commands
## like catkin build (line 57) and catkin_init_workspace (line 72) in a Docker
RUN apt update && apt install -y -qq \
    python3-pip \
    python3-yaml \
    python-catkin-tools \
    python3-dev \
    python3-numpy && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install \
    rospkg \
    catkin_pkg \
    numpy==1.24.3 && \
	mkdir ~/catkin_build_ws && cd ~/catkin_build_ws && \
    catkin config -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_INCLUDE_DIR=/usr/include/python3.8 -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.8.so && \
    catkin config --install && \
    mkdir src && cd src && \
    git clone -b melodic https://github.com/ros-perception/vision_opencv.git && \
	cd ~/catkin_build_ws && \
	/bin/bash -c 'source /opt/ros/melodic/setup.bash && \
	catkin build cv_bridge'

# Install ros-realsense
## The /bin/bash -c format is needed to overcome an issue with commands
## like catkin_init_workspace and catkin_make in a Dockerfile
RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash && \
    mkdir -p ~/catkin_ws/src && cd ~/catkin_ws/src/ && \
    git clone https://github.com/IntelRealSense/realsense-ros.git && \
    cd realsense-ros/ && \
    git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1` && \
    apt update && apt install -y -qq \
    ros-melodic-ddynamic-reconfigure && \
    cd ~/catkin_ws && \
    catkin_make clean && \
    catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release && \
    catkin_make install' && \
    apt remove -y ros-melodic-cv-bridge
    
# Install requirements for gesture recognition and person tracking
RUN pip3 install --ignore-installed PyYAML \
    simple-pid==2.0.0 \
    ultralytics==8.0.157 \
    supervision==0.13.0 \
    mediapipe==0.10.1 \
    opencv_contrib_python==4.7.0.72 
    
# Add ROS source to bashrc and refresh
RUN /bin/bash -c 'echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    echo "source ~/catkin_build_ws/install/setup.bash --extend" >> ~/.bashrc && \
    source ~/.bashrc'

# Show shell at startup
CMD ["bash"]
