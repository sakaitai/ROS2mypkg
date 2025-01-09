#!/bin/bash
# SPDX-FileCopyrightText: 2024 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/ros2_ws/install/setup.bash

timeout 50 ros2 run ros2mypkg baito_publisher > /tmp/ros2mypkg.log &  


sleep 2

cat /tmp/mypkg.log | grep -e '経過時間': -e '累計収入'


kill %1
