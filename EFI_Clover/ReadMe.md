#### 2019-09-05

- 从`SSDT-AIR13IWL.aml`中分离并移除 `FakePCIID_Intel_HDMI_Audio.kext` ,移除 `FakePCIID.kext` 
- 更新`小兵`新编译的`AppleALC.kext`添加HDMI音频支持,相关修改已提交至`AppleALC.kext`项目
- 随着`WhateverGreen.kext`的更新,移除显卡部分不再需要的属性

#### 2019-09-02

+ 修改驱动`VoodooPS2Controller.kext`内的`VoodooPS2Keyboard.kext`PS2键盘驱动实现下列功能
  + 屏蔽错误的亮度快捷键 `Fn+K`、`Fn+P`
  + 添加`PrtSc` = 播放/暂停
  + 关闭 `Command` 、`Option` 交换位置选项

#### 2019-08-30
+ 更新Clover版本到5058
+ 整合`SSDT-XOSI.aml` , `SSDT-XCPM.aml` , `SSDT-PNLF.aml` , `SSDT-SBUS.aml` , `SSDT-EC.aml` , `SSDT-Q11Q12.aml` , `SSDT-GPRW.aml` 合并为`Air13IWL.aml`
+ 整合`CPUFriendProvider.kext` , `FakePCIID_Intel_HDMI_Audio.kext` , `XHCI-unsupported.kext` , `USBPorts.kext` 合并为`SSDT-Air13IWL.kext`
+ 蓝牙驱动`BrcmPatchRAM2.kext`经过修改只适合蓝牙ID为`0a5c `:` 6412`的`DW1820A`使用

----
#### 历史更新
----

- 8-7-2019
  - 修复蓝牙驱动，`DW1820A` 可以正常使用了
  
- 5-22-2019
  - **添加对`DW1820A`无线网卡的支持**
  - 测试环境：macOS Mojave 10.14.5 18F132，截屏见上方
  
- 5-16-2019
  - 更新`CLOVER`版本到4928
  - 其它的常规更新
  
- 12-17-2018
  - 修改了声卡的驱动方式，移除`FakePCIID`+`FakePCIID_Intel_HDMI_Audio`
  - VirtualSMC更新到v1.0.2，包括传感器插件
  - SSDT更新，触摸板可通过连续按5次`F6`或者`WIN`键关闭或者开启
  
- 12-4-2018
  - 更新`AppleALC` v1.3.4，已提交到`vit9696`合并完毕
  - 全新仿冒了小新AIR的声卡id：99
  
- 11-25-2018
  - 修改显卡驱动方式：
    - Whiskey lake仿冒Coffee lake
    - platform-id注入id:`3e9b0006`
    - 可完美睡眠唤醒，可调节屏幕亮度
  - 声卡驱动方式：
    - 采用`AppleALC`仿冒原生驱动`AppleHDA`
    - ALC236注入id:2
    - 驱动方式：`FakePCI-ID`+`FakePCIID_Intel_HDMI_Audio`
  - 添加`ALCPlugFix`守护进程，解决耳机/耳麦自动切换，解决睡眠唤醒