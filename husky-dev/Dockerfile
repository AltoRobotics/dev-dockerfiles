ARG ros_distro=foxy
ARG from=ros:${ros_distro}-ros-base
ARG ssh_private_key=/root/.ssh/id_rsa
FROM ${from}

# No GUIs for the time being, they might come in later

# Set up noninteractive package installation
ENV DEBIAN_FRONTEND=noninteractive

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

# Set up McFly
RUN curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly && \
    echo '\neval "$(mcfly init bash)"\n' >> /root/.bashrc && \
    touch /root/.bash_history

# Copy private repo from /tmp/dotconfig without needing a ssh key
COPY dotconfig /etc/dotconfig
RUN ln -s /etc/dotconfig/.tmux.conf /root/.tmux.conf && \
    ln -s /etc/dotconfig/.bash_aliases /root/.bash_aliases && \
    ln -s /etc/dotconfig/.vimrc /root/.vimrc

# Set up Clearpath Husky stuff
RUN wget https://packages.clearpathrobotics.com/public.key -O - | apt-key add - && \
    sh -c 'echo "deb https://packages.clearpathrobotics.com/stable/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/clearpath-latest.list'

RUN apt update && apt install -y \
    ros-${ROS_DISTRO}-husky-robot
    # ros-${ROS_DISTRO}-husky-desktop \
    # ros-${ROS_DISTRO}-husky-simulator

# Use Bash from now on (necessary for sourcing) (use ".")
SHELL ["/bin/bash", "-c"]

# Set up a husky workspace
RUN mkdir -p /husky_ws/src && \
    source /opt/ros/${ROS_DISTRO}/setup.bash && \
    cd /husky_ws && colcon build

# Set up configs
COPY husky_config /etc/husky_config
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    source /etc/husky_config/husky_config.env && \
    ros2 run husky_bringup install

# Missing: source .env at startup

# Show shell at startup
CMD ["bash"]