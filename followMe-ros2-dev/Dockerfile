ARG ros_distro=humble
ARG from=osrf/ros:${ros_distro}-desktop-full
ARG ssh_private_key=/root/.ssh/id_rsa
FROM ${from}

# Set up noninteractive package installation
ENV DEBIAN_FRONTEND=noninteractive


###### This first part is copied from Fabrizio's ros-opengl-dev docker image #####

# Dependencies for glvnd and X11.
RUN apt update && \
    apt install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 && \
    rm -rf /var/lib/apt/lists/*

# Install packages to test x11 and OpenGL 2.0 pipeline
RUN apt update && \
    apt install -y -qq --no-install-recommends \
    mesa-utils \
    glmark2 && \
    rm -rf /var/lib/apt/lists/*

# Install development-related packages
RUN apt update && apt install -y \
    git \
    build-essential \
    gdb \
    cmake-curses-gui \
    ninja-build \
    python3-wheel \
    python3-pip \
    nano \
    openssh-client \
    curl \
    lsb-release \
    wget \
    unzip \
    locales \
    software-properties-common \
    tmux \
    htop \
    mc \
    vim \
    && apt upgrade -y

# Set up Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    echo '\neval "$(starship init bash)"' >> /root/.bashrc

# Set up McFly
RUN curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly && \
    echo 'eval "$(mcfly init bash)"\n' >> /root/.bashrc && \
    touch /root/.bash_history

# Copy private repo from /tmp/dotconfig without needing a ssh key
COPY dotconfig /etc/dotconfig
RUN ln -s /etc/dotconfig/.tmux.conf /root/.tmux.conf && \
    ln -s /etc/dotconfig/.bash_aliases /root/.bash_aliases && \
    ln -s /etc/dotconfig/.vimrc /root/.vimrc

# Some QT-Apps/Gazebo don't show controls without this
ENV QT_X11_NO_MITSHM 1
ENV QT_GRAPHICSSYSTEM "native"

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute


###### This second part is related to the follow-me demo ######

# Install librealsense and realsense-ros
RUN apt update && \
    sudo apt install -y -qq ros-humble-librealsense2* && \
    sudo apt install -y -qq ros-humble-realsense2-*

# Install gesture recognition requirements
RUN apt update && apt install -y -qq \
    libcanberra-gtk-module \
    libcanberra-gtk3-module && \
    pip install --ignore-installed \
    mediapipe==0.10.7 \
    numpy==1.26.1 \
    opencv_contrib_python==4.8.1.78

# Install YOLOv8 requirements
RUN pip install --ignore-installed \
    ultralytics==8.0.213 \
    supervision==0.16 && \
    pip uninstall -y \
    matplotlib \
    opencv_python_headless

# Prepare ros2 workspace
RUN mkdir -p /root/ros2_ws/src && \
#    cd /root/ros2_ws/src && git clone git@github.com:AltoRobotics/ros2-follow-me.git && \
    cd /root/ros2_ws && colcon build

# Add ROS source to bashrc and refresh
## The /bin/bash -c format is needed to overcome an issue with source command in Dockerfile
RUN /bin/bash -c 'echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc && \
    source /root/.bashrc'

# Show shell at startup
CMD ["bash"]

