# Air13IWL-Clover-1.3.0
- 更新 Clover 版本至 Releases - 5096
- 更新 `SSDT-BUS0.aml` 更接近白果 , 添加 `SSDT-SLPB.aml` (PNP0C0E) 丢失的部件
- 更新部分驱动至最新版本 Releases , 移除 `XHCI-unsupported.kext` ( 并未发现使用与否有区别 )
- 默认使用机型 `MacBook Pro 15,4`
- macOS 10.15 Catalina 临时解锁系统分区 , 用以开启 HIDPI 、安装 ALCPlugFix 和 重建缓存
  - 终端执行以下命令
    - 挂载为可写模式 : `sudo mount -uw /`
    - 重启 Finder : `killall Finder`
    - 重建缓存 : `sudo kextcache -i /`
# Air13IWL-Clover-1.2.0
- 移除补丁 `SSDT-AIR13IWL.aml`  , 重新整理 [HotPatch](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/blob/master/HotPatch/ReadMe.md) 添加下列部件补丁
  - `SSDT-XOSI.aml` 、`SSDT-MCHC.aml` 、`SSDT-DMAC.aml` 、`SSDT-HPTE.aml` 、`SSDT-EC.aml` 、`SSDT-BKEY.aml` 、`SSDT-PMCR.aml` 、`SSDT-BUS0.aml` 、`SSDT-PR00.aml` 、`SSDT-PNLF.aml` 、`SSDT-GPRW.aml` 、`SSDT-RMCF.aml`
- 移除驱动 `SMCSuperIO.kext` 、`AIR13IWL.kext` , 添加下列驱动
  - `XHCI-unsupported.kext` 、`USBPorts.kext` 、`CPUFriendDataProvider.kext`
- 重新使用 `SSDT-RMCF.aml` 定制PS2键盘按键映射 , 还原原版 `VoodooPS2Controller.kext` 驱动 
  - 屏蔽错误的亮度调整快捷键 `Fn+K` 、`Fn+P`
  - 添加 `PrtSc` = 系统电源键
  - 添加 `Command` 、`Option` 交换位置
    - `Command` = `Windows` 、`Option = Alt`
- `Config.plist`
  - 移除 `AppleLPC` 仿冒属性 , 电源键功能由 `SSDT-PMCR.aml` 取代
  - 移除关于屏蔽 `AppleIntelLpssI2C` 的属性 , 不再需要
# Air13IWL-Clover-1.1.0
- 更新 Clover 版本至 5070
- 更新驱动至最新 Releases 版
- 添加文件保险箱功能的相关驱动
# 启用以Releases版本号为基础的更新日志
# 2019-09-05
- 从`SSDT-AIR13IWL.aml`中分离并移除 `FakePCIID_Intel_HDMI_Audio.kext` ,移除 `FakePCIID.kext`
- 更新 `小兵` 新编译的`AppleALC.kext`添加HDMI音频支持,相关修改已提交至 `AppleALC.kext` 项目
- 随着 `WhateverGreen.kext` 的更新,移除显卡部分不再需要的属性
# 2019-09-02
- 修改驱动 `VoodooPS2Controller.kext` 内的 `VoodooPS2Keyboard.kext` PS2 键盘驱动实现下列功能
  - 屏蔽错误的亮度快捷键 `Fn + K` 、`Fn + P`
  - 添加 `PrtSc` = 播放 / 暂停
  - 关闭 `Command` 、`Option` 交换位置选项
# 2019-08-30
- 更新 Clover 版本到 5058
- 整合 `SSDT-XOSI.aml` 、`SSDT-XCPM.aml` 、`SSDT-PNLF.aml` 、`SSDT-SBUS.aml` 、 `SSDT-EC.aml` 、`SSDT-Q11Q12.aml` 、`SSDT-GPRW.aml` 合并为 `Air13IWL.aml`
- 整合 `CPUFriendDataProvider.kext` 、`FakePCIID_Intel_HDMI_Audio.kext` 、`XHCI-unsupported.kext` 、`USBPorts.kext` 合并为 `SSDT-Air13IWL.kext`
- 蓝牙驱动 `BrcmPatchRAM2.kext` 经过修改只适合蓝牙 ID 为 `0a5c ` : ` 6412` 的 `DW1820A` 使用
# 历史更新
# 8-7-2019
  - 修复蓝牙驱动 , `DW1820A` 可以正常使用了
# 5-22-2019
  - **添加对`DW1820A`无线网卡的支持**
  - 测试环境 : macOS Mojave 10.14.5 18F132 , 截屏见上方
# 5-16-2019
  - 更新 `CLOVER` 版本到 4928
  - 其它的常规更新
# 12-17-2018
  - 修改了声卡的驱动方式 , 移除`FakePCIID` + `FakePCIID_Intel_HDMI_Audio`
  - VirtualSMC 更新到v1.0.2 , 包括传感器插件
  - SSDT更新 , 触摸板可通过连续按5次 `F6` 或者 `WIN` 键关闭或者开启
# 12-4-2018
  - 更新 `AppleALC` v1.3.4 , 已提交到 `vit9696` 合并完毕
  - 全新仿冒了 小新AIR 的声卡id : 99
# 11-25-2018
  - 修改显卡驱动方式 :
    - Whiskey lake 仿冒 Coffee lake
    - platform-id 注入 id : `3e9b0006`
    - 可完美睡眠唤醒 , 可调节屏幕亮度
  - 声卡驱动方式：
    - 采用 `AppleALC` 仿冒原生驱动 `AppleHDA`
    - ALC236 注入id : 2
    - 驱动方式 : `FakePCI-ID` + `FakePCIID_Intel_HDMI_Audio`
  - 添加 `ALCPlugFix` 守护进程 , 解决耳机 / 耳麦自动切换 , 解决睡眠唤醒