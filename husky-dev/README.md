# Husky bringup container

Modify the configuration in `husky_config/husky_config.env` according to [the specs](./husky_config/configuration.md).

Build the image by simply running

```shell
ROS_DISTRO=foxy ./build.sh
```

Run the container by using either the script

```shell
./run.sh foxy-husky-dev alto/ros:foxy-husky-dev
```

or simply

```shell
docker compose up -d
```