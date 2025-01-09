# SPDX-FileCopyrightText: 2024 Taisei Sakai
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import time

class BaitoPublisher(Node):

    def __init__(self):
        super().__init__('baito_publisher')  # ノード名
        self.publisher_ = self.create_publisher(String, 'baito_time', 10)  # トピック名
        self.start_time = time.time()
        self.timer = self.create_timer(1.0, self.timer_callback)

        self.hourly_rate = 1300  # 時給
        self.warning_threshold = 60 * 60 * 8  # 8時間で警告

    def timer_callback(self):
        elapsed_time = time.time() - self.start_time
        total_seconds = int(elapsed_time)
        earned_money = (total_seconds / 3600) * self.hourly_rate

        warning_message = ""
        if total_seconds > self.warning_threshold:
            warning_message = "※注意: 8時間を超えました！休憩を取ってください。"

        # トピックに送信するメッセージ
        msg = String()
        msg.data = (
            f'経過時間: {total_seconds}秒'
            f'累計収入: {int(earned_money)}円'
            f'{warning_message}'
        )
        self.publisher_.publish(msg)

def main(args=None):
    rclpy.init(args=args)
    node = BaitoPublisher()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
