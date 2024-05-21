# ROS2 Follow Me Demo

Docker image containing all the requirements to run and develop the follow-me pipeline with ROS2 Humble.

Further documentation about the demo itself can be found [here](https://github.com/AltoRobotics/ros2-follow-me.git)!

---

## Usage:

**Note: Unplug any RealSense camera from the device while building the image!**

Clone the dev-dockerfiles repo, enter the followMe-ros2-dev folder, and build the Docker image (it will take some minutes due to some heavy installations):
```shell
git clone https://github.com/AltoRobotics/dev-dockerfiles.git
cd followMe-ros2-dev
./build.sh
```

Then, run the `run.sh` script to create a container with all the settings you need. Install the `nvidia-container-runtime` package alongside Docker and add the `--gpus all` flag into the `run.sh` if you want to leverage a discrete Nvidia GPU.

```shell
 ./run.sh ros2-followMe alto/ros-humble:followMe-dev
```

Once the container starts, clone the [follow-me package](https://github.com/AltoRobotics/ros2-follow-me.git) containing the ROS2 nodes in the appropriate workspace, build everything, and source the `setup.bash` script:
```shell
cd ~/ros2_ws/src
git clone https://github.com/AltoRobotics/ros2-follow-me.git
cd ..
colcon build
source install/setup.bash
```

Finally, you can run the demo with a single launch file:
```shell
ros2 launch person_follow_me follow_me_demo.launch.py
```

or launching individually each node:
```shell
ros2 launch realsense2_camera rs_launch.py align_depth.enable:=true
```
```shell
ros2 launch robot_state_signaling robot_state_signaling.launch.py
```
```shell
ros2 launch gesture_recognition gesture_recognition.launch.py
```
```shell
ros2 launch person_follow_me person_follow_me.launch.py
```
