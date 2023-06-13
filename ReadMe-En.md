# Lenovo Air 13 IWL Hackintosh

[CN](ReadMe.md) | [EN](ReadMe-En.md) 

## Computer configuration
| Spec           | Detailed information                                                |
| -------------- | ------------------------------------------------------------------- |
| Model          |  Lenovo Air 13 IWL / Ideapad S530-13 IWL                            |
| OS             | MacBookPro15,4 (Ventura 13 / Monterey 12 / Big Sur 11/ Catalina 10.15) |
| CPU            | Intel Core i5 - 8265U / i7-8565U                                    |
| RAM            | 8GB / 16GB LPDDR3 1867MHz                                           |
| Memory         | Nvme SSD 256G / 512G                                         |
| GPU            | Intel UHD Graphics 620 Whiskey Lake - U GT3                  |
| Display        | 13.3 Inches. FHD 1920x1080                                      |
| Sound Card     | Realtek ALC236                                               |
| Network card   | Replace with BCM94360CS2 / BCM943602CS                                          |
- [Suggestions for BIOS settings before installation](BIOSConfig.md)
- Installation Tutorial: [[**Black Fruit Creeps Tribe Pavilion**]: Lenovo Air 13 / Ideapad S530-13 IWL macOS Mojave installation tutorial](https://blog.daliansky.net/Lenovo-Xiaoxin-Air-13-macOS-Mojave-installation-tutorial.html)
- Mirror download: [[**Black Fruit Creeps Tribal Pavilion**]: [Black Fruit Creeps] Original mirror](https://blog.daliansky.net/categories/下载/镜像/)
- EFI Releases Download : [Gitee](https://gitee.com/xlivans/Air13IWL/releases) , [GitHub](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/releases) , [Tencent Micro Cloud](https://share.weiyun.com/5yMO9jB)
- [Hot patch information](HotPatch/ReadMe.md)
- [Configuration information](Config.md)
- [Changelog](Changelog.md)

## Which can work better
- Due to the current hibernation can not wake up normally, in order to avoid affecting sleep, the terminal uses the following command
  - Close hibernation
    ```bash
    sudo pmset -a hibernatemode 0
    ```
  - Close iCloud device near wake-up
    ```bash
    sudo pmset -a proximitywake 0
    ```
  - Clear and lock the `com.apple.AutoWake.plist` file on `Ventura 13` to prevent scheduled tasks from waking up ( this operation will affect functions such as `Find My Mac` )
    ```bash 
    sudo pmset sched cancelall
    sudo pmset repeat cancel
    sudo chflags schg /Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist
    ```
    Updating the system will result in the file being overwritten and locked out , Please repeat the above operation , Manually unlock the command
    ```bash 
    sudo chflags noschg /Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist
    ```
- Enable HIDPI to improve system UI quality. The terminal uses the following command to turn HIDPI on or off
  - Suitable for Ventura 13
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-HiDPI-Ventura.sh)"
    ```
  - Suitable for Monterey 12 / Big Sur 11/ Catalina 10.15
    ```bash
    bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-HiDPI.sh)"
    ```
- Install ALCPlugFix-Swift to fix 3.5 mm headset switching exception issue, It is done by using the command: ` alc verb 0x19 SET_ PIN_ WIDGET_ Control 0x25 ` for state switching, applicable to versions after **AppleALC 1.5.4** , the terminal uses the following command to install or uninstall ALCPlugFix
  ```bash
  bash -c "$(curl -fsSL https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Air13IWL-ALCPlugFix.sh)"
  ```

## Thanks
- **Acidanthera** for [OpenCore](https://github.com/acidanthera/OpenCorePkg) and [Related drivers](https://github.com/acidanthera)
- **black-dragon74** for [ALCPlugFix-Swift](https://github.com/black-dragon74/ALCPlugFix-Swift)
- **alexandred** for [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C/)
- **宪武** for [OC-little](https://github.com/daliansky/OC-little)

QQ Group: 943181023 [Lenovo Xiaoxin Air Hackintosh communication group](https://shang.qq.com/wpa/qunwpa?idkey=fb772a7e01436d43e1d856a099549551952bb08161ced4a8fc08b4e75e7ab438) 

