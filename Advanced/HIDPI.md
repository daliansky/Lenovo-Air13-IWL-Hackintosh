# 开启macOS HIDPI
## 简介
macOS 的 DPI 机制和 Windows 下不一样 , 比如 1080P 的屏幕在 Windows 下有 125% 、150% 这样的缩放选项 , 而同样的屏幕在 macOS 下 , 缩放选项里只是单纯的调节分辨率 , 这就使得在默认分辨率下字体和UI看起来很小 , 降低分辨率又显得模糊 , 此脚本的目的是为开启 HiDPI 选项 , 使屏幕具有原生的 HIDPI 设置 , 不需要 RDM 软件即可在系统显示器设置中设置 , 开机的第二阶段 logo 总是会稍微放大 , 因为分辨率是仿冒的
## 使用方法
- 在终端执行
  - `bash -c "$(curl -fsSL https://raw.githubusercontent.com/xzhih/one-key-hidpi/master/hidpi.sh)"`
## 恢复
如果使用此脚本后 , 开机无法进入系统 , 请到 macos 恢复模式中 , 打开终端 , 执行以下命令：

- `ls /Volumes/`
- `cd /Volumes/你的系统盘/System/Library/Displays/Contents/Resources/Overrides/HIDPI`
- `./disable`

## 鸣谢
- **xzhih** 提供 [one-key-hidpi](https://github.com/xzhih/one-key-hidpi)