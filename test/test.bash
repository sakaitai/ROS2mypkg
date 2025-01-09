#!/bin/bash
# SPDX-FileCopyrightText: 2025 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws"
source "$dir/ros2_ws/install/setup.bash"

timeout 10 ros2 run ros2mypkg baito_publisher > /tmp/ros2mypkg.log

grep -e '経過時間' -e '累計収入' -e '注意' /tmp/ros2mypkg.log

