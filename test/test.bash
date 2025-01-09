#!/bin/bash
# SPDX-FileCopyrightText: 2024 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build

# ROS 2 のセットアップスクリプトをソース
source /opt/ros/foxy/setup.bash
source $dir/ros2_ws/install/setup.bash

# ノードを実行し、ログを保存
timeout 10 ros2 run ros2mypkg baito_publisher > /tmp/ros2mypkg.log &

sleep 2

# ログファイルの内容を検索
grep -e '経過時間' -e '累計収入' -e '注意' /tmp/ros2mypkg.log

