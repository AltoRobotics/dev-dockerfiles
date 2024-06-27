# Valkyrie simulated setup

This contains instructions to bring up a simulated version of the Valkyrie robot and a web UI service to command its movements.

# Building the simulated Valkyrie image

**Important** this step will pull from a private repo under github.com/AltoRobotics. Make sure you have set up permissions to do so.

To build the Docker image containing all the Gazebo-simulated Valkyrie software, including ROS2 and relative dependencies, simply run

```shell
ROS_DISTRO=humble ./build.sh
```

A Docker image named `develer/ros:<ROS_DISTRO>` will be generated.

# Running a container

To start a container run

```shell
./run.sh valkyrie `develer/ros:<ROS_DISTRO>`
```

substituting your desired ROS distro to `<ROS_DISTRO>` (at the moment `humble`). Then, to launch the Valkyrie simulation, run

```shell
ros2 launch valkyrie_bringup valkyrie_bringup_sim.launch.py launch_teleop:=false use_sim:=true
```

in the container shell.
