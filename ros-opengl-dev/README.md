# ros-opengl-dev

Use this repo to play around with a dockerized ROS environment with a working OpenGL pipeline.

---

### Usage:

Build the image via the `build.sh` script. Make sure to specify the `ROS_DISTRO` variable inside the script. If you want to leverage a discrete nVidia GPU, make sure to install the `nvidia-container-runtime` package alongside Docker and add the `--gpus all` flag inside the `run.sh`.

#### Integrated video card

```shell
cd integrated
./build.sh
./run.sh
```

#### Dedicated video card

```shell
cd nvidia_discrete
./build.sh
./run.sh
```

In this case, the run file will also print the output of `nvidia-smi` as a further debug tool.