#!/bin/bash
# SPDX-FileCopyrightText: 2025 TAISEI SAKAI
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd "$dir/ros2_ws"

# ROS 2ワークスペースのセットアップスクリプトをロード
if [ -f "$dir/ros2_ws/install/setup.bash" ]; then
    source "$dir/ros2_ws/install/setup.bash"
else
    echo "エラー: ROS 2ワークスペースのセットアップスクリプトが見つかりません。"
    exit 1
fi

# ros2コマンドが利用可能か確認
ros2 --help > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "エラー: ros2コマンドが利用できません。環境設定を確認してください。"
    exit 1
fi

# baito_publisherノードを実行
timeout 30 ros2 run ros2mypkg baito_publisher > /tmp/ros2mypkg.log
if [ $? -ne 0 ]; then
    echo "エラー: baito_publisherノードの実行に失敗しました。"
    exit 1
fi

# ログファイルの解析
grep -e '経過時間' -e '累計収入' -e '注意' /tmp/ros2mypkg.log
if [ $? -ne 0 ]; then
    echo "エラー: 必要な情報がログに見つかりませんでした。"
    exit 1
fi

echo "テストが正常に完了しました。"
exit 0

