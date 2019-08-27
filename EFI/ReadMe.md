## Lenovo 小新 Air13IWL `(xlivans)`

### 感谢 宪武 小兵 各位群友 大佬们 为此机型的辛苦付出

配置说明 : https://github.com/xlivans/Air13IWL

更新日志 : https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/tree/master/EFI/Changelog.md

#### 个人非主流修改说明：

+ OC使用的`SSDT-AIR13IWL.aml` 由下列补丁合并而来
  + `SSDT-PNLF.aml` : CFL定制亮度补丁
  + `SSDT-SBUS.aml` : SMBus系统管理总线补丁
  + `SSDT-GPRW.aml` : USB(0d/6d)断电补丁
  + `SSDT-XCPM.aml` : CPU电源管理补丁
  + `SSDT-TPXX.aml` : I2C触摸板轮询补丁
  + `SSDT-EC.aml` : EC仿冒补丁
+ Clover使用的`SSDT-AIR13IWL.aml` 由下列补丁合并而来
  + `SSDT-PNLF.aml` : CFL定制亮度补丁
  + `SSDT-SBUS.aml` : SMBus系统管理总线补丁
  + `SSDT-XOSI.aml` : 操作系统补丁
  + `SSDT-GPRW.aml` : USB(0d/6d)断电补丁
  + `SSDT-XCPM.aml` : CPU电源管理补丁
  + `SSDT-EC.aml` : EC仿冒补丁
  + `SSDT-Q11Q12.aml` : 亮度快捷键补丁
+ 驱动中的`AIR13IWL.kext`由下列驱动合并而来
  + `CPUFriendDataProvider.kext` : CPU电源管理数据驱动
  + `FakePCIID_Intel_HDMI_Audio.kext` : HDMI音频驱动
  + `XHCI-unsupported.kext` ：USB总线控制器驱动
  + `USBPorts.kext` ：USB端口定制驱动
+ 声卡驱动`AppleALC.kext`经过定制使用注意事项如下
  + ID : `98` (62000000)
    + 各项表现正常 ，3.5mm麦克风需要手动切换
  + ID : `99` (63000000)
    + 需要添加`CodecCommander.kext`驱动,并安装`ALCPlugFix`声卡守护进程,3.5mm麦克风支持自动切换,当睡眠唤醒或连接耳麦开机的情况下出现的耳机声音异常,重新插拔即可
+ 蓝牙驱动`BrcmPatchRAM2.kext`经过修改只适合蓝牙ID为`0a5c `:` 6412`的`DW1820A`使用
+ OC中`VoodooPS2Controller.kext`内的`VoodooPS2Keyboard.kext`PS2键盘驱动经过修改实现下列功能
  + 屏蔽错误的亮度快捷键 `Fn+K`、`Fn+P`
  + 添加`Fn+F4` =上一曲
  + 添加`Fn+F7` =下一曲
  + 添加`PrtSc` = 播放/暂停
  + 添加`Fn+F11` = 亮度减少
  + 添加`Fn+F12` = 亮度增加
  + 关闭 `Command` 、`Option` 交换位置选项

