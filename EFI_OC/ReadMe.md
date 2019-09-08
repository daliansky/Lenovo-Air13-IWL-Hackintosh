#### Air13IWL-OC-1.1.0

- 更新OpenCore版本至0.5.0
- 更新驱动至最新Releases版
- 添加文件保险箱功能的相关驱动

------

#### 启用以Releases版本号为基础的更新日志

------

#### 2019-09-05

+ 从`SSDT-AIR13IWL.aml`中分离并移除 `FakePCIID_Intel_HDMI_Audio.kext` ,移除 `FakePCIID.kext` 

+ 更新`小兵`新编译的`AppleALC.kext`添加HDMI音频支持,相关修改已提交至`AppleALC.kext`项目

+ 随着`WhateverGreen.kext`的更新,移除显卡部分不再需要的属性

#### 2019-08-30

+ 合并`SSDT-TPXX.aml`至`SSDT-AIR13IWL.aml`
+ 移除`SSDT-RMCFMap.aml`,修改驱动`VoodooPS2Controller.kext`内的`VoodooPS2Keyboard.kext`PS2键盘驱动实现下列功能
  + 屏蔽错误的亮度快捷键 `Fn+K`、`Fn+P`
  + 添加`Fn+F4` =上一曲
  + 添加`Fn+F7` =下一曲
  + 添加`PrtSc` = 播放/暂停
  + 添加`Fn+F11` = 亮度减少
  + 添加`Fn+F12` = 亮度增加
  + 关闭 `Command` 、`Option` 交换位置选项

#### 2019-08-20

+ 移除操作系统更名,移除亮度快捷键更名及其相关补丁

+ 使用`SSDT-RMCFMap.aml`定制PS2键盘,屏蔽无用键,新增功能键
    + Fn+F4=上一曲
    + Fn+F7=下一曲
    + PrtSc=播放/暂停
+ 由于移除操作系统更名,使用`SSDT-TPXX.aml`驱动触摸板

#### 2019-08-13

+ 更新`宪武`大佬最新`GPRW`补丁,合并至`SSDT-Air13IWL.aml`

#### 2019-08-12

+ 更新`Acidanthera`所有引导,驱动,工具至Releases版

#### 2019-08-10

+ 更新OpenCore至0.0.4版本,更新对应版本`Config.plist`
+ 更新`EFI`-`OC`-`Drivers`驱动,移除`AptioMemoryFix.efi`,增加`FwRuntimeServices.efi`
+ 更新`EFI`-`OC`-`Tools`工具
+ 默认打开 `BrcmFirmwareData.kext` , `BrcmPatchRAM2.kext`（`DW1820A`蓝牙驱动）,此驱动经过修改只适合ID：`0a5c_6412`使用

#### 2019-08-05

+ 移除所有更名的限制查找条件以保证不同版本BIOS的通用性

#### 2019-08-04

+ 移除`SSDT-Air13IWL.aml`中的`OCOS`补丁
+ 添加`宪武`大佬最新`Windows 2018 to Darwin`操作系统更名

#### 2019-08-03

+ 移除声卡注入`device-id`，修改`Air13IWL.kext`，声卡驱动`AppleALC.kext`可单独使用不在受`FakePCIID.kext`和`FakePCIID_Intel_HDMI_Audio.kext`影响，使用HDMI音频仍需`FakePCIID.kext`
+ 参考`宪武`大佬关于`AptioMemoryFix.efi`正确使用方式，默认打开`Config.plist`-`Kernel`-`Quirks`-`DisableIoMapper`，同时建议在隐藏BIOS禁用`CFG Lock`
+ 添加启动项`Verify MsrE2`可查看MsrE2(CFG Lock)锁定解锁状态
+ 移除部分驱动内的非必要文件，移除`Config.plist`-`NVRAM`-`LegacySchema`下内容

#### 2019-07-27

+ 合并更新`SSDT-Air13IWL.aml`、`SSDT-GPRW.aml`
+ 从`Air13IWL.kext`中分离`BrcmBluetoothInjector.kext `
+ 补全部分更名参数
+ 添加启动工具`UEFI Shell`和`Clean Nvram`
+ 补全部分NVRAM为OC官方推荐项

#### 2019-07-25

+ 添加部分NVRAM参数
+ 上传完整EFI目录方便单系统用户直接替换

#### 2019-07-17

+ 添加`GPRW to XPRW`更名,`0D/6D`补丁,暂时性解决睡眠秒醒问题.
+ 更新配置文件:默认打开所有设备引导扫描,如需关闭修改`Config.plist`-`Misc`-`Security`-`ScanPolicy`为`983299`

#### 2019-07-15
+ 使用OpenCore-0.0.3-Releases .
+ 使用前先补全`Config.plist` - `PlatformInfo` - `Generic`下的空白内容.
+ 已更换`DW1820A`蓝牙ID为`0a5c`,`6412`的可以直接使用(仍需配合虚拟机大法).
+ 目前已知问题:插入USB设备时会有睡眠秒醒问题,添加`0d/6d`补丁可解决!
+ 整合`SSDT-OCOS.aml` , `SSDT-XCPM.aml` , `SSDT-PNLF.aml` , `SSDT-SBUS.aml` , `SSDT-EC.aml` , `SSDT-Q11Q12.aml` 合并为`SSDT-Air13IWL.aml`
+ 整合`CPUFriendProvider.kext` , `FakePCIID_Intel_HDMI_Audio.kext` , `XHCI-unsupported.kext` , `USBPorts.kext` , `BrcmBluetoothInjector.kext` 合并为`Air13IWL.kext`