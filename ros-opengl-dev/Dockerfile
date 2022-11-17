ARG ros_distro=melodic
ARG from=osrf/ros:${ros_distro}-desktop-full

FROM ${from}

# Set up noninteractive package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set up generic locales
# RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && \
    # locale-gen &&\
    # update-locale LANG="en_US.UTF-8"

# Dependencies for glvnd and X11.
RUN apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 && \
    rm -rf /var/lib/apt/lists/*

# Install packages to test x11 and OpenGL 2.0 pipeline
RUN apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    mesa-utils \
    glmark2 && \
    rm -rf /var/lib/apt/lists/*

# Install development-related packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    gdb \
    cmake-curses-gui \
    nano \
    curl \
    lsb-release \
    wget \
    unzip \
    locales \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Some QT-Apps/Gazebo don't show controls without this
ENV QT_X11_NO_MITSHM 1

# Show shell at startup
CMD ["bash"]
