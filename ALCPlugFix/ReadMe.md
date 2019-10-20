# ALCPlugFix_for_ALC_node12_19

## 简介

- 它可以解决耳机插拔状态的切换。
- 它是通过使用命令 : `hda-verb 0xNode SET_PIN_WIDGET_CONTROL 0xVerbs` 的方式进行状态切换
- `hda-verb` 是原本来自于linux下面的 `alsa-project` 的一条命令 , 它的作用是发送HD-audio命令
## 注意：
- 每次开机和睡眠唤醒后 , 你可能需要重新插拔耳机来让耳机正常工作
- 安装前需要确认 SIP 为关闭状态 , 使用本仓库的EFI,默认为关闭状态
  - macOS 10.15 Catalina 需要临时解锁系统分区 , 终端执行以下命令后再安装
    - 挂载为可写模式 : `sudo mount -uw /`
    - 重启 Finder : `killall Finder`
## 鸣谢
- 感谢 [goodwin](https://github.com/goodwin) 和 [Menchen](https://github.com/Menchen/ALCPlugFix) 提供和维护 [ALCPlugFix](https://github.com/goodwin/ALCPlugFix)
- 感谢 [Rehabman](https://github.com/RehabMan) 提供 [hda-verb](https://github.com/RehabMan/EAPD-Codec-Commander) 的维护