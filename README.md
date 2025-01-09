# ロボットシステム学のROS2のパッケージです
[![test](https://github.com/sakaitai/ros2mypkg/actions/workflows/test.yml/badge.svg)](https://github.com/sakaitai/ros2mypkg/actions/workflows/test.yml)

## とんかつバイト時給秒換算システム
- このリポジトリは、自分の働いているバイト先の時給を一秒ごとに教えてくれるROS2のノードです。

## 概要
- 一秒ごとに秒換算されたバイトの時給が足されていきます。時給は1300円です。
- 労働時間が8時間を超えたら休憩を知らせるための警告が出ます。


## 使用方法
1. このパッケージをセットアップし、依存関係をインストールします。
2. ノードを起動し、

## 使用方法
以下のコマンドで実行

```
$ ros2 run ros2mypkg baito_publisher
```
別の端末で以下のコマンドで確認

```
$ ros2 topic echo /baito_time
```

実行結果

```
data: '経過時間: 7秒,累計収入: 2円'
---
data: '経過時間: 8秒,累計収入: 2円'
---
data: '経過時間: 9秒,累計収入: 3円'
---
```

以下は8時間 (28800秒)超えた時に出るメッセージです
  
```
data: '経過時間: 28801秒,累計収入: 10400円※注意: 8時間を超えました！休憩 を取ってください。'
---
```

## 動作環境
- Ubuntu 20.04

- ROS2バージョン foxy

## ライセンスと著作権
- このソフトウェアパッケージは[3条項BSDライセンス](https://github.com/sakaitai/ros2mypkg/blob/main/LICENSE)の下、再頒布および使用が許可されています。
-  *© 2025 Taisei Sakai*
