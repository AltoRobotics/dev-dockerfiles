ARG ros_distro=humble
ARG from=osrf/ros:${ros_distro}-desktop-full
ARG ssh_private_key=/root/.ssh/id_rsa
FROM ${from}

# Set up noninteractive package installation
ENV DEBIAN_FRONTEND=noninteractive

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
    && apt upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Set up Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    echo '\neval "$(starship init bash)"\n' >> /root/.bashrc

# Set up McFly
RUN curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly && \
    echo '\neval "$(mcfly init bash)"\n' >> /root/.bashrc && \
    touch /root/.bash_history

# Copy private repo from /tmp/dotconfig without needing a ssh key
COPY dotconfig /etc/dotconfig
RUN ln -s /etc/dotconfig/.tmux.conf /root/.tmux.conf && \
    ln -s /etc/dotconfig/.bash_aliases /root/.bash_aliases && \
    ln -s /etc/dotconfig/.vimrc /root/.vimrc

# Some QT-Apps/Gazebo don't show controls without this
ENV QT_X11_NO_MITSHM 1

# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Show shell at startup
CMD ["bash"]
