# ros-opengl-dev

Use this repo to play around with a dockerized ROS environment with a working OpenGL pipeline.

---

### Usage:

Build the image via the `build.sh` script. Make sure to specify the `ROS_DISTRO` when running the script. If you want to leverage a discrete nVidia GPU, make sure to install the `nvidia-container-runtime` package alongside Docker and add the `--gpus all` flag inside the `run.sh`.

If the needed ros distribution is `humble`, for instance

```shell
ROS_DISTRO=humble ./build.sh
./run.sh ros-container alto/ros:humble-dev
```
