#!/bin/bash -xv
# SPDX-FileCopyrightText: 2024 Reo Isaka
# SPDX-License-Identifier: BSD-3-Clause

# デフォルトの作業ディレクトリを設定
dir=~
[ "$1" != "" ] && dir="$1"

# ROS 2ワークスペースのディレクトリに移動
cd "$dir/ros2_ws" || { echo "指定されたディレクトリが存在しません: $dir/ros2_ws"; exit 1; }

# ワークスペースをビルド
colcon build || { echo "ビルドに失敗しました。"; exit 1; }

# 環境変数を読み込む
source "$dir/.bashrc" || { echo ".bashrcの読み込みに失敗しました。"; exit 1; }

# baito_publisherノードをバックグラウンドで起動
ros2 run ros2mypkg baito_publisher &
publisher_pid=$!

# ノードが起動するのを待機
sleep 2

# トピックの出力を一時ファイルに保存
timeout 10 ros2 topic echo /baito_time > /tmp/ros2mypkg_topic.log

# 期待するメッセージが含まれているか確認
grep -q 'data: 2' /tmp/ros2mypkg_topic.log && echo "メッセージ 'data: 2' を確認しました。"
grep -q 'data: 3' /tmp/ros2mypkg_topic.log && echo "メッセージ 'data: 3' を確認しました。"
grep -q 'data: 3' /tmp/ros2mypkg_topic.log && echo "メッセージ 'data: 3' を確認しました。"

# バックグラウンドで起動したノードを終了
kill "$publisher_pid"
wait "$publisher_pid" 2>/dev/null

echo "テストが完了しました。"

