# demo-ros-melodic

You can use this repo to create the environment for the demo with a dockerized ROS1 Melodic environment and a working OpenGL pipeline.

The demo consists of:
 - a Realsense node acquiring camera info, RGB frames, and depth frames, and aligning them, before publishing on the respective topics;
 - a robot state signaling service-node, which receives commands from the follow-me application (in this case, but any other application can intervene) and sets the robot LEDs color and pattern in accordance with the current state;
 - a gesture recognition node, which detects and recognizes gestures performed by the people in the scene and publishes their class and XY position in the frame;
 - and a follow-me node, which manages the subject detection and tracking, together with the RB1 robot control, according to the gestures being performed in front of the robot. 

![image](https://github.com/AltoRobotics/dev-dockerfiles/assets/32684998/2b526d25-8a59-462a-9578-14709657aa48)

---

## Usage:

**Note: Unplug any RealSense camera from the device while building the image!**

Build the ros-opengl-dev image first via the `build.sh` script, specifying the `ROS_DISTRO` as melodic when running the script.
Build the ros-melodic:demo-dev image via the `build.sh` script.
Finally, run the `run.sh` script to install everything that's needed for the demo (librealsense, ros-realsense, python3.8 and the related cv_bridge for ROS1, ...). Make sure to install the `nvidia-container-runtime` package alongside Docker and add the `--gpus all` if you want to leverage a discrete nVidia GPU.

```shell
cd ros-opengl-dev
ROS_DISTRO=melodic
./build.sh

cd ../demo-ros-melodic
docker build -t alto/ros-melodic:demo-dev .
./run.sh demo-container alto/ros-melodic:demo-dev
```

Once the container starts, clone the respective ROS nodes in _~/catkin_ws/src_:
 - [robot_signaling_state](https://github.com/AltoRobotics/robot-state-signaling/tree/ros1-leds) [ros1-leds branch]
 - [gesture-recognition](https://github.com/AltoRobotics/gesture-recognition) [main branch]
 - [follow-me repositories](https://github.com/AltoRobotics/object-detection-tracking) [main branch]
and run them in the following order to run the demo:

```shell
roslaunch realsense2_camera rs_camera.launch align_depth:=true
```
```shell
rosrun robot_state_signaling robot_state_signaling_node_python.py
```
```shell
roslaunch gesture_recognition gesture_recognition.launch PARAM1:=VALUE1 ...
```
```shell
roslaunch object_detection_tracking person_follow_me.launch PARAM1:=VALUE1 ...
```
