#!/bin/bash -xv
# SPDX-FileCopyrightText: 2025 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc
ros2 launch ros2mypkg temp.launch.py &

timeout 10 ros2 topic echo /baito_publisher.launch.py > /tmp/ros2mypkg.log

cat /tmp/ros2mypkg.log | grep 'earn maney'
