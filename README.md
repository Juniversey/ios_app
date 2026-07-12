# ExamCountdown - 考试倒计时

纯 SwiftUI 编写的 iOS 考试倒计时应用。

## 功能

- 添加多个考试，自动按日期排序
- 显示距离每个考试还有多少天
- 颜色区分：绿色（>30天）、橙色（7-30天）、红色（≤7天）、灰色（已过期）
- 数据持久化，重启不丢失

## 在本地运行

需要 Xcode 14+ 和 iOS 16+ 的部署目标。

1. 打开 `ExamCountdown.xcodeproj`
2. 选择你的设备或模拟器
3. 按 Cmd+R 运行

## 使用 Codemagic 构建

1. 将代码推送到 GitHub
2. 连接 GitHub 仓库到 Codemagic
3. 点击 "Build" 即可在云端编译
4. 编译完成后下载 .ipa 文件

## 许可证

MIT
