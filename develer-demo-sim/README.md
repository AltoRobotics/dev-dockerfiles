# Valkyrie simulated setup

This contains instructions to bring up a simulated version of the Valkyrie robot and a web UI service to command its movements.

# Building the simulated Valkyrie and Web UI images

**Important** this step will pull from a private repo under github.com/AltoRobotics. Make sure you have set up permissions to do so.

To build all the Docker images containing all the Gazebo-simulated Valkyrie software, including ROS2 and relative dependencies, and the Web application, simply run

```shell
ROS_DISTRO=humble ./build.sh
```

Two Docker images named `develer/ros:<ROS_DISTRO>` and `develer/teleop-control` will be generated.

# Running the containers

To start the containers run

```shell
./run.sh
```

This will also launch the Valkyrie simulation and the Web server and it will open the Web UI using the default Web browser.

# Stopping the containers

To stop the containers run

```shell
./stop.sh
```

# ERRORS

If you have error like 
```shell
=> CANCELED [teleop-control internal] load metadata for docker.io/library/alpine:latest                                                                                                   0.4s
=> ERROR [teleop-control internal] load metadata for docker.io/library/node:16-alpine                                                                                                     0.4s
=> CANCELED [teleop-control internal] load metadata for docker.io/library/golang:1.18-alpine                                                                                              0.4s
=> ERROR  [valkyrie internal] load metadata for docker.io/osrf/ros:humble-desktop
```

look at 

**https://stackoverflow.com/questions/66912085/why-is-docker-compose-failing-with-error-internal-load-metadata-suddenly**
