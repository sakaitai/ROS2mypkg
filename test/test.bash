#!/bin/bash
# SPDX-FileCopyrightText: 2025 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc
timeout 50 ros2 launch ros2mypkg baito_publisher > /tmp/ros2mypkg.log 



cat /tmp/ros2mypkg.log | grep -e '経過時間': -e '累計収入'
