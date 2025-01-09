#!/bin/bash
# SPDX-FileCopyrightText: 2024 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/ros2_ws/install/setup.bash

timeout 10 ros2 run ros2mypkg baito_publisher > /tmp/ros2mypkg.log &  


sleep 2

cat /tmp/mypkg.log | grep -e '秒 とんかつバイト: ' -e '円'


kill %1

