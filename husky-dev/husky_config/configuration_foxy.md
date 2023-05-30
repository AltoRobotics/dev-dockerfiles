# Environment variables for Husky configuration on Foxy

These are all the environment variables that are used in the Foxy branch of the Husky ROS2 packages. Most of these are useful for activating features of the robot, while some are probably legacy and/or unused.

## Robot description
### Package husky_description (husky_macro.urdf.xacro)
#### Laser

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_LASER_ENABLED`                     | 0                         | Configuration includes LIDAR |
| `CPR_LASER_XYZ`                         | 0.2206 0.0 0.00635        | Laser frame position wrt ? |
| `CPR_LASER_RPY`                         | 0.0 0.0 0.0               | Laser frame orientation wrt ? |

#### Realsense

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_REALSENSE`                         | 0                         | Configuration includes Realsense |
| `CPR_REALSENSE_XYZ`                     | 0 0 0                     | Realsense frame position wrt ? |
| `CPR_REALSENSE_RPY`                     | 0.0 0.0 0.0               | Laser frame orientation wrt ? |
| `CPR_REALSENSE_MOUNT_FRAME`             | `sensor_arch_mount_link`  | Where the Realsense is mounted |

#### Bumpers

| Env variable name                       | Default                   | Description |
| - | - | - |
| `HUSKY_FRONT_BUMPER_EXTEND`             | 0                         | Whether front tubular bumper is installed (will show up in urdf) |
| `HUSKY_REAR_BUMPER_EXTEND`              | 0                         | Whether rear tubular bumper is installed (will show up in urdf) |

#### Extras

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_URDF_EXTRAS`                       | `empty.urdf`              | Not sure what this does, maybe additional URDF input? |
| `HUSKY_SERIAL_PORT`                     | `/dev/prolific`           | Default serial port for Husky communication. Must be mapped via udev rule |

#### IMU

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_IMU_XYZ`                           | 0 0 0                     | IMU frame position wrt ? |
| `CPR_IMU_RPY`                           | 0.0 0.0 0.0               | IMU frame orientation ? |

#### GPS

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_GPS_XYZ`                           | 0 0 0                     | GPS frame position wrt ? |
| `CPR_GPS_RPY`                           | 0.0 0.0 0.0               | GPS frame orientation wrt ? |


### Package husky_description (decorations.urdf.xacro)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `HUSKY_USER_RAIL_ENABLED`               | 0                         | Whether the user rail is installed (will show up in urdf) |
| `HUSKY_TOP_PLATE_ENABLED`               | 0                         | Whether the top plate is installed (will show up in urdf) |
| `HUSKY_LARGE_TOP_PLATE`                 | 0                         | Whether the LARGE top plate is installed (will show up in urdf) |

### Package husky_description (description.launch)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `HUSKY_LMS1XX_ENABLED`                  | `false`                   | Enables laser in urdf (PROBABLY LEGACY AND UNUSED) |
| `HUSKY_REALSENSE_ENABLED`               | `false`                   | Enables realsense in urdf (PROBABLY LEGACY AND UNUSED) |
| `HUSKY_URDF_EXTRAS`                     | `false`                   | Enables husky extras in urdf (PROBABLY LEGACY AND UNUSED) |

## Robot bringup configuration
### Package husky_bringup (accessories.launch.py)
#### Primary laser (front)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_LASER`                             | `false`                   | Enable primary lidar |
| `CPR_LASER_MODEL`                       | `ust10`                   | Primary lidar model `{ust10}` |
| `CPR_LASER_HOST`                        | `192.168.131.20`          | Primary lidar IP |
| `CPR_LASER_TOPIC`                       | `front/scan`              | Primary lidar topic |
| `CPR_LASER_MOUNT`                       | `front_laser`             | Frame the primary lidar is attached to |

#### Secondary laser (rear)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_LASER_SECONDARY`                             | `false`                   | Enable secondary lidar |
| `CPR_LASER_SECONDARY_MODEL`                       | `ust10`                   | Secondary lidar model `{ust10}` |
| `CPR_LASER_SECONDARY_HOST`                        | `192.168.131.21`          | Secondary lidar IP |
| `CPR_LASER_SECONDARY_TOPIC`                       | `rear/scan`              | Secondary lidar topic |
| `CPR_LASER_SECONDARY_MOUNT`                       | `rear_laser`             | Frame the secondary lidar is attached to |

#### 3D laser

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_3D_LASER`                             | `false`                   | Enable 3D lidar |
| `CPR_3D_LASER_MODEL`                       | `vlp16`                   | 3D lidar model `{vlp16, vlp32c}` |
| `CPR_3D_LASER_HOST`                        | `192.168.131.20`          | 3D lidar IP |
| `CPR_3D_LASER_TOPIC`                       | `mid/points`              | 3D lidar topic |
| `CPR_3D_LASER_MOUNT`                       | `mid_velodyne`             | Frame the 3D lidar is attached to |

#### IMU

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_IMU`                                 | `false`                       | Enable IMU |
| `CPR_IMU_MODEL`                           | `microstrain`                 | IMU model `{microstrain}` |
| `CPR_IMU_PORT`                            | `/dev/microstrain`            | IMU serial port (maybe mapped via udev rule) |
| `CPR_IMU_BAUD`                            | `115200`                      | IMU serial baud rate |
| `CPR_IMU_MOUNT`                           | `imu_link`                    | IMU attachment link |


#### Realsense

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_REALSENSE`                         | `false`                   | Enable Intel Realsense |

## Robot control options
### Package husky_control (control.launch.py, teleop_joy.launch.py)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `CPR_IMU`                                 | `false`                       | Enable IMU |
| `CPR_JOY_TYPE`                            | `logitech`                    | Which joypad configuration to load into teleop |

### Package husky_control (control.launch, teleop.launch)
(Unsure if these are legacy and unused, given their XML format and weird naming conventions)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `HUSKY_JOY_DEVICE`                      | `/dev/input/js0`          | Joypad device for teleoperation |
| `HUSKY_LOGITECH`                        | 0                         | Whether a Logitech joypad is being used for teleoperation |
| `ROBOT_MULTIMASTER`                     | `false`                   | ? |
| `ROBOT_SIMULATION`                      | `false`                   | Whether the robot is being simulated or not |
| `ROBOT_NAMESPACE`                       | `robot`                   | ROS namespace for everything |
| `ENABLE_EKF`                            | `true`                    | Extended Kalman Filter is enabled for IMU data |
| `HUSKY_CONFIG_EXTRAS`                   | ?                         | ? |
| `HUSKY_LMS1XX_ENABLED`                  | `false`                   | Laser is enabled |
| `HUSKY_REALSENSE_ENABLED`               | `false`                   | Realsense is installed |
| `HUSKY_URDF_EXTRAS`                     | ?                         | ? |

## Robot gazebo configuration
### Package husky_gazebo (gazebo.launch.py)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `GAZEBO_MODEL_PATH`                     | None                      | Where gazebo should look for models |

### Package husky_gazebo (spawn_husky.launch)
(Unsure if these are legacy and unused, given their XML format and weird naming conventions)

| Env variable name                       | Default                   | Description |
| - | - | - |
| `HUSKY_LMS1XX_ENABLED`                  | `false`                   | Laser is enabled |
| `HUSKY_REALSENSE_ENABLED`               | `false`                   | Realsense is installed |
| `HUSKY_URDF_EXTRAS`                     | ?                         | ? |

