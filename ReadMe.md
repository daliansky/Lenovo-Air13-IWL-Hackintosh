# Lenovo Air 13 IWL Hackintosh
## Computer configuration
| Spec           | Detailed information                                                |
| -------------- | ------------------------------------------------------------------- |
| Model          |  Lenovo Air 13 IWL / Ideapad S530-13 IWL                            |
| OS             | macOS Big Sur 11 / Catalina 10.15 / Mojave 10.14 / High Sierra 10.13 |
| CPU            | Intel Core i5 - 8265U / i7-8565U                                    |
| RAM            | 8GB / 16GB LPDDR3 1867MHz                                           |
| Memory         | Nvme SSD 256G / 512G                                         |
| GPU            | Intel UHD Graphics 620 Whiskey Lake - U GT3                  |
| Display        | 13.3 Inches. FHD 1920x1080                                      |
| Sound Card     | Realtek ALC236                                               |
| Network card   | Replace with Dell DW1820A                                          |
- Because the driver of the Acidanthera development group no longer does compatibility testing for Clover, abandon Clover and use OpenCore boot scheme

- Installation Tutorial: [[**Black Fruit Creeps Tribe Pavilion**]: Lenovo Air 13 / Ideapad S530-13 IWL macOS Mojave installation tutorial](https://blog.daliansky.net/Lenovo-Xiaoxin-Air-13-macOS-Mojave-installation-tutorial.html)
- Mirror download: [[**Black Fruit Creeps Tribal Pavilion**]: [Black Fruit Creeps] Original mirror](https://blog.daliansky.net/categories/下载/镜像/)
- [Clover Final Version 2019-12-04 Releases 1.4.0 Download](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/releases/tag/1.4.0)
- [EFI Relsases Download](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/releases)
- [Tencent Micro Cloud](https://share.weiyun.com/5yMO9jB)
- [Configuration description](Advanced/ReadMe.md)
- [Changelog](Changelog.md)
## Which can work better
- Due to the current hibernation can not wake up normally, in order to avoid affecting sleep, the terminal uses the following command to close hibernation
  
  - `sudo pmset -a hibernatemode 0`
- Open HIDPI to improve the quality of the system UI, the terminal uses the following command to turn HIDPI on or off
  - Suitable for macOS 10.15 and macOS 11
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Tools/raw/master/Air13IWL-HiDPI.sh)"
    ```
  - Suitable for macOS 10.14 or earlier versions
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Tools/raw/master/hidpi-zh.sh)"
    ```
- Install ALCPlugFix-Swift to fix 3.5 mm headset switching exception issue, it is done by using the command : `alc-verb 0x19 SET_PIN_WIDGET_CONTROL 0x25` To switch status, for versions after **AppleALC 1.5.4**, the terminal uses the following command to install or uninstall ALCPlugFix
  ```bash
  bash -c "$(curl -fsSL https://gitee.com/xlivans/Tools/raw/master/Air13IWL-ALCPlugFix.sh)"
  ```
- Windows and MacOS [Bluetooth device dual system sharing](Advanced/Bluetooth.md)
- OpenCoreMenu section [Frequently Asked Questions](Advanced/OCMenu.md)
- OpenCoreUsing Native Apple [Boot Disk (BootCamp)](Advanced/BootCamp.md) Switching dual systems
## Thanks
- **Acidanthera** for [OpenCore](https://github.com/acidanthera/OpenCorePkg) and [Related drivers](https://github.com/acidanthera)
- **black-dragon74** for [ALCPlugFix-Swift](https://github.com/black-dragon74/ALCPlugFix-Swift)
- **al3xtjames** for [NoTouchID](https://github.com/al3xtjames/NoTouchID)
- **alexandred** for [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C/)
- **宪武** for [OC-little](https://github.com/daliansky/OC-little)
## About Reward
If you approve of my work, please support my follow-up updates by rewarding

| WeChat                                                      | Alipay                                               |
| ---------------------------------------------------------- | ---------------------------------------------------- |
| ![wechatpay_160](http://7.daliansky.net/wechatpay_160.jpg) | ![alipay_160](http://7.daliansky.net/alipay_160.jpg) |
## QQ群:
- 331686786  [一起吃苹果](http://shang.qq.com/wpa/qunwpa?idkey=db511a29e856f37cbb871108ffa77a6e79dde47e491b8f2c8d8fe4d3c310de91)
- 688324116 [一起黑苹果](https://shang.qq.com/wpa/qunwpa?idkey=6bf69a6f4b983dce94ab42e439f02195dfd19a1601522c10ad41f4df97e0da82)
- 943181023 [联想小新 Air 黑苹果交流群](https://shang.qq.com/wpa/qunwpa?idkey=fb772a7e01436d43e1d856a099549551952bb08161ced4a8fc08b4e75e7ab438) 
- 128630866 [ThinkPad 黑苹果交流群](https://jq.qq.com/?_wv=1027&k=5aKxc6n)
