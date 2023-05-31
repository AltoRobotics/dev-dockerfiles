# Husky bringup container


## Set up udev rules

Copy the content of the [udev](./udev/) directory into `/etc/udev/rules.d` and reload them before starting the container.

```shell
sudo cp udev/*.rules /etc/udev/rules.d
sudo udevadm control --reload-rules && sudo udevadm trigger
```

## Build and run

Modify the configuration in `husky_config/husky_config.env` according to [the specs](./husky_config/configuration_foxy.md).

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

Please note that I set the `ROS_DOMAIN_ID` to 11 in the [compose YAML](./docker-compose.yaml) for no particular reason other than I like the number 11.
