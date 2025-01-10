#!/bin/bash
# SPDX-FileCopyrightText: 2024 Taisei Sakai
# SPDX-License-Identifier: BSD-3-Clause

# デフォルトの作業ディレクトリ
dir=~
[ "$1" != "" ] && dir="$1"

# ROS2 ワークスペースに移動してビルド
cd $dir/ros2_ws || exit 1
colcon build || exit 1

# ROS2 環境をセットアップ
source $dir/ros2_ws/install/setup.bash || {
    echo "ERROR: ROS 2 環境のセットアップに失敗しました。" >&2
    exit 1
}

# テスト用のログファイル
log_file="/tmp/ros2mypkg.log"

# ROS2 ノードをバックグラウンドで起動
timeout 50 ros2 run ros2mypkg baito_publisher > "$log_file" 2>&1 &
ros_pid=$!

# プロセスが起動するのを待つ
sleep 2

# テスト内容: 経過時間と累計収入の出力を確認
if ! grep -q -e '経過時間' -e '累計収入' "$log_file"; then
    echo "ERROR: 必要な出力がログに含まれていません。" >&2
    kill "$ros_pid" 2>/dev/null
    exit 1
fi

# バックグラウンドプロセスを終了
kill "$ros_pid" 2>/dev/null

# 終了ステータスを確認
wait "$ros_pid" 2>/dev/null || true

echo "テスト成功: 出力を確認しました。"
exit 0

