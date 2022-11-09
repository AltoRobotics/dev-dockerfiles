ARG from=ubuntu:jammy
FROM ${from}

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
