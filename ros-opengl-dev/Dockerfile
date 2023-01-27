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
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Set up Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    echo '\neval "$(starship init bash)"\n' >> /root/.bashrc

# Set up McFly
RUN curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly && \
    echo '\neval "$(mcfly init bash)"\n' >> /root/.bashrc && \
    touch /root/.bash_history

# Set up github as known host for ssh
RUN mkdir /root/.ssh/ \
 && touch /root/.ssh/known_hosts \
 && ssh-keyscan github.com >> /root/.ssh/known_hosts

# Clone private repo without explicitly copying the ssh key
RUN --mount=type=secret,id=ssh_id,target=/root/.ssh/id_rsa \
    git clone git@github.com:AltoRobotics/dotconfig.git /etc/dotconfig && \
    ln -s /etc/dotconfig/.tmux.conf /root/.tmux.conf

# Some QT-Apps/Gazebo don't show controls without this
ENV QT_X11_NO_MITSHM 1

# Show shell at startup
CMD ["bash"]
