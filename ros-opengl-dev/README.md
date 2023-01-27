# ros-opengl-dev

Use this repo to play around with a dockerized ROS environment with a working OpenGL pipeline.

---

### Usage:

Build the image via the `build.sh` script. Make sure to specify the `ROS_DISTRO` when running the script. If you want to leverage a discrete nVidia GPU, make sure to install the `nvidia-container-runtime` package alongside Docker and add the `--gpus all` flag inside the `run.sh`.

If the needed ros distribution is `melodic`, for instance

```shell
ROS_DISTRO=melodic ./build.sh
./run.sh ros-container alto/ros:melodic-dev
```

In order to clone private repos from the Alto private repo, you'll need to register a ssh key to GitHub. If such key were, for instance, stored in `/home/fbottarel/.ssh/github_id_rsa` then build the image with 

```shell
SSH_PRIVATE_KEY=/home/fbottarel/.ssh/github_id_rsa ./build.sh
./run.sh ros-container alto/ros:melodic-dev
```

You won't need to remove your ssh key afterwards nor it will remain in any Docker layer, since this Dockerfile makes use of the [BuildKit ssh mount type](https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mounttypessh).