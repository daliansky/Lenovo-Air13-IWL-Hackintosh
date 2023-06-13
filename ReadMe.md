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
- [EFI Relsases 下载](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/releases)
- [腾讯微云](https://share.weiyun.com/5yMO9jB)
- [配置说明](Advanced/ReadMe.md)
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
- 开启 HIDPI 来提升系统 UI 质量 , 终端使用以下命开启或关闭 HIDPI
  - 适用于 Ventura 13
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-HiDPI-Ventura.sh)"
    ```
  - 适用于 Monterey 12 / Big Sur 11/ Catalina 10.15
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-HiDPI.sh)"
    ```
- 安装 ALCPlugFix-Swift 来修复 3.5 mm 耳麦切换异常问题 , 它是通过使用命令 : `alc-verb 0x19 SET_PIN_WIDGET_CONTROL 0x25` 进行状态切换 , 适用于 **AppleALC 1.5.4** 之后的版本, 终端使用以下命安装或卸载 ALCPlugFix
  ```bash
  bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-ALCPlugFix.sh)"
  ```
- Windows 和 MacOS [蓝牙设备双系统共用](Advanced/Bluetooth.md)
- OpenCore 菜单部分 [常见问题](Advanced/OCMenu.md)
- OpenCore 使用原生苹果 [启动磁盘 ( BootCamp )](Advanced/BootCamp.md) 切换双系统
## 鸣谢
- **Acidanthera** 提供 [OpenCore](https://github.com/acidanthera/OpenCorePkg) 和 [相关驱动](https://github.com/acidanthera)
- **black-dragon74** 提供 [ALCPlugFix-Swift](https://github.com/black-dragon74/ALCPlugFix-Swift)
- **alexandred** 提供 [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C/)
- **宪武** 提供 [OC-little](https://github.com/daliansky/OC-little)
## 关于打赏
如果您认可我的工作，请通过打赏支持我后续的更新

| 微信                                                       | 支付宝                                               |
| ---------------------------------------------------------- | ---------------------------------------------------- |
| ![wechatpay_160](http://7.daliansky.net/wechatpay_160.jpg) | ![alipay_160](http://7.daliansky.net/alipay_160.jpg) |
## QQ群:
- 331686786  [一起吃苹果](http://shang.qq.com/wpa/qunwpa?idkey=db511a29e856f37cbb871108ffa77a6e79dde47e491b8f2c8d8fe4d3c310de91)
- 688324116 [一起黑苹果](https://shang.qq.com/wpa/qunwpa?idkey=6bf69a6f4b983dce94ab42e439f02195dfd19a1601522c10ad41f4df97e0da82)
- 943181023 [联想小新 Air 黑苹果交流群](https://shang.qq.com/wpa/qunwpa?idkey=fb772a7e01436d43e1d856a099549551952bb08161ced4a8fc08b4e75e7ab438) 
- 128630866 [ThinkPad 黑苹果交流群](https://jq.qq.com/?_wv=1027&k=5aKxc6n)