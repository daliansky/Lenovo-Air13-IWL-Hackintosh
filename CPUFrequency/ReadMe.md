# CPU 变频数据定制

## 使用方法

- 终端执行
  - `bash -c "$(curl -fsSL https://raw.githubusercontent.com/daliansky/Lenovo-Air13-IWL-Hackintosh/master/CPUFrequency/View.sh)"`
  - 输入密码,选`nano`继续,记下高亮绿色的机型`Mac-53FDB3D8DB8CA971.plist`(根据自己实际情况选择一个合适的记下),查看即可不要继续执行,强制关闭终端![View](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/blob/master/Advanced/Pictures/View.png)
- 终端执行
  - `cp /System/Library/Extensions/IOPlatformPluginFamily.kext/Contents/PlugIns/X86PlatformPlugin.kext/Contents/Resources/Mac-53FDB3D8DB8CA971.plist ~/desktop/CPU.plist`
  - 修改桌面`CPU.plist`最低频率为800Mhz ![CPU](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/blob/master/Advanced/Pictures/CPU.png)
- 终端执行
  - `bash -c "$(curl -fsSL https://raw.githubusercontent.com/daliansky/Lenovo-Air13-IWL-Hackintosh/master/CPUFrequency/Data.sh)"`
  - 桌面得到 `CPUFriendDataProvider.kext`

## 鸣谢

- 感谢 [Piker-Alpha](https://github.com/Piker-Alpha/freqVectorsEdit.sh) 提供脚本

