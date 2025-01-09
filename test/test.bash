#!/bin/bash
# SPDX-FileCopyrightText: 2025 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

# ROS 2 ワークスペースに移動
cd "$dir/ros2_ws" || { echo "ディレクトリが見つかりません: $dir/ros2_ws"; exit 1; }

# ROS 2 環境セットアップ
source "$dir/ros2_ws/install/setup.bash"
echo "ROS 2 コマンド確認: $(which ros2)"

# ログファイルの指定
LOG_FILE="/tmp/ros2mypkg.log"

# ノードを実行してログを保存
timeout 10 ros2 run ros2mypkg baito_publisher > "$LOG_FILE" 2>&1 &
ROS_PID=$!

# 実行結果を待機
sleep 2

# ログファイルの内容を確認
if [ -f "$LOG_FILE" ]; then
  echo "=== ログファイルの内容 ==="
  cat "$LOG_FILE" | grep -e '経過時間' -e '累計収入' -e '注意'
else
  echo "ログファイルが作成されていません。"
fi

# ノードを終了（必要なら）
kill $ROS_PID 2>/dev/null || true

# 終了メッセージ
echo "テストが完了しました。ログファイルは $LOG_FILE に保存されています。"

