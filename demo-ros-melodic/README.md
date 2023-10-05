# demo-ros-melodic

Use this repo to create the environment for the gesture-recognition and follow-me applications with a dockerized ROS1 Melodic environment and a working OpenGL pipeline.

Once the container starts, clone the respective gesture-recognition and follow-me repositories in ```~/catkin_ws/src''' to run the demo.

Note: Unplug any RealSense camera from the device while building the image!
---

### Usage:

Build the ros-opengl-dev image first via the `build.sh` script, specifying the `ROS_DISTRO` as melodic when running the script.
Build the ros-melodic:demo-dev image via the `build.sh` script.
Finally, run the `run.sh` script to install everything that's needed for the demo (librealsense, ros-realsense, python3.8 and the related cv_bridge for ROS1, ...). Make sure to install the `nvidia-container-runtime` package alongside Docker and add the `--gpus all` if you want to leverage a discrete nVidia GPU.

```shell
ROS_DISTRO=melodic
../ros-opengl-dev/build.sh

docker build -t alto/ros-melodic:demo-dev .
./run.sh demo-container alto/ros-melodic:demo-dev
```
