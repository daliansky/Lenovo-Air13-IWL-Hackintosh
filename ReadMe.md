# Lenovo Air 13 IWL Hackintosh
[CN](ReadMe.md) | [EN](ReadMe-En.md)

## 电脑配置

| 规格     | 详细信息                                                     |
| -------- | ------------------------------------------------------------ |
| 电脑型号 | 联想小新 Lenovo Air 13 IWL 笔记本电脑 |
| 机型系统 | MacBookPro15,4 (Ventura 13 / Monterey 12 / Big Sur 11/ Catalina 10.15) |
| 处理器   | 英特尔 酷睿 i5 - 8265U / i7-8565U |
| 内存     | 8GB / 16GB LPDDR3 1867MHz |
| 硬盘     | Nvme SSD 256G / 512G |
| 显卡     | Intel UHD Graphics 620 Whiskey Lake - U GT3 |
| 显示器   | 13.3 英寸 FHD 1920x1080 |
| 声卡     | Realtek ALC236 |
| 网卡     | 更换为苹果拆机卡 BCM94360CS2 / BCM943602CS (使用软排线转接) |
- [安装前 BIOS 设置建议](BIOSConfig.md)
- 安装教程 : [[**黑果小兵的部落阁**] : 联想小新Air 13安装黑苹果兼macOS Mojave安装教程](https://blog.daliansky.net/Lenovo-Xiaoxin-Air-13-macOS-Mojave-installation-tutorial.html)
- 镜像下载 : [[**黑果小兵的部落阁**] :【黑果小兵】原版镜像](https://blog.daliansky.net/categories/下载/镜像/)
- EFI Releases 下载 : [Gitee](https://gitee.com/xlivans/Air13IWL/releases) , [GitHub](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/releases) , [腾讯微云](https://share.weiyun.com/5yMO9jB)
- [热补丁信息](HotPatch/ReadMe.md)
- [配置信息](Config.md)
- [更新日志](Changelog.md)

## 哪些可以工作得更好
- 因目前休眠无法正常唤醒 , 为避免影响到睡眠 , 终端使用以下命令
  - 关闭休眠
    ```bash
    sudo pmset -a hibernatemode 0
    ```
  - 关闭 iCloud 设备接近唤醒
    ```bash
    sudo pmset -a proximitywake 0
    ```
  - 在 `Ventura 13` 上清空并锁定 `com.apple.AutoWake.plist` ⽂件以防止计划任务唤醒 ( 此操作将影响`查找我的Mac`等功能 )
    ```bash 
    sudo pmset sched cancelall
    sudo pmset repeat cancel
    sudo chflags schg /Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist
    ```
    更新系统将导致⽂件被覆盖锁定失效 , 请重复以上操作 , 手动解锁命令
    ```bash 
    sudo chflags noschg /Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist
    ```
    
- 开启 HIDPI 来提升系统 UI 质量 , 终端使用以下命开启或关闭 HIDPI
  - 适用于 Ventura 13
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-HiDPI-Ventura.sh)"
    ```
  - 适用于 Monterey 12 / Big Sur 11/ Catalina 10.15
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-HiDPI.sh)"
    ```

- 安装 ALCPlugFix-Swift 修复 3.5 mm 耳麦切换异常问题 , 终端使用以下命安装或卸载 ALCPlugFix
  ```bash 
  bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-ALCPlugFix.sh)"
  ```
  **安装后 : 系统设置 - 隐私与安全 - 麦克风 - ALCPlugFix 打开 , 系统设置 - 通用 - 登陆项 - 允许在后台 - ALCPlugfix 打开**

- 安装 sleepwatcher 和 blueutil 来修复蓝牙睡眠唤醒后异常问题 , 它在睡眠时关闭蓝牙唤醒时重新打开 , 终端使用以下命安装或卸载 sleepwatcher
  ```bash
  bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/BlueSleepFix.sh)"
  ```
  **安装后 : 系统设置 - 隐私与安全 - 输入监控 - sleepwatcher 打开 , 系统设置 - 通用 - 登陆项 - 允许在后台 - sleepwatcher 打开**

## 鸣谢
- **Acidanthera** 提供 [OpenCore](https://github.com/acidanthera/OpenCorePkg) 和 [相关驱动](https://github.com/acidanthera)
- **black-dragon74** 提供 [ALCPlugFix-Swift](https://github.com/black-dragon74/ALCPlugFix-Swift)
- **alexandred** 提供 [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C/)
- **宪武** 提供 [OC-little](https://github.com/daliansky/OC-little)

## QQ群:
- 331686786 [一起吃苹果]
- 688324116 [一起黑苹果]
- 943181023 [联想小新 Air 黑苹果交流群]
- 128630866 [ThinkPad 黑苹果交流群]

