# Air13IWL-OC-1.3.0
- 更新 OpenCore 版本至 Releases - 0.5.1
- 更新 `SSDT-OSYS.aml` , 添加 `Windows to Xindows` 更名 , 使 Windows 10 和 MacOS 双系统工作状态保持一致
- 更新 `SSDT-BUS0.aml` 更接近白果 , 添加 `SSDT-SLPB.aml` ( PNP0C0E ) 丢失的部件
- 移除 `AppleGenericInput.efi` ( 已合并进 OC )
- 更新部分驱动至最新版本 Releases , 移除 `XHCI-unsupported.kext` ( 并未发现使用与否有区别 ) 
- 补全删减掉的 `Config.plist` 内容 , 保持和官方样本一致
- 默认使用机型 `MacBook Pro 15,4` , 更新 SIP 关闭参数 `csr-active-config` :  `e7030000`
- macOS 10.15 Catalina 临时解锁系统分区 , 用以开启 HIDPI 、安装 ALCPlugFix 和 重建缓存
  - 终端执行以下命令
    - 挂载为可写模式 : `sudo mount -uw /`
    - 重启 Finder : `killall Finder`
    - 重建缓存 : `sudo kextcache -i /`
- [OpenCore 单系统建议](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/blob/master/SingleSystem/ReadMe.md)
# Air13IWL-OC-1.2.0
- 移除补丁 `SSDT-AIR13IWL.aml`  , 重新整理 [HotPatch](https://github.com/daliansky/Lenovo-Air13-IWL-Hackintosh/blob/master/HotPatch/ReadMe.md) 添加下列部件补丁
  - `SSDT-OSYS.aml` 、`SSDT-MCHC.aml` 、`SSDT-DMAC.aml` 、`SSDT-HPTE.aml` 、`SSDT-EC.aml` 、`SSDT-BKEY.aml` 、`SSDT-PMCR.aml` 、`SSDT-BUS0.aml` 、`SSDT-PR00.aml` 、`SSDT-PNLF.aml` 、`SSDT-GPRW.aml` 、`SSDT-RMCF.aml`
- 移除驱动 `SMCSuperIO.kext` 、`AIR13IWL.kext` , 添加下列驱动
  - `XHCI-unsupported.kext` 、`USBPorts.kext` 、`CPUFriendDataProvider.kext`
- 重新使用 `SSDT-RMCF.aml` 定制 PS2 键盘按键映射 , 还原原版 `VoodooPS2Controller.kext` 驱动 
  - 屏蔽错误的亮度调整快捷键 `Fn + K` 、`Fn + P`
  - 添加 `PrtSc` = 系统电源键
  - 添加 `Command` 、`Option` 交换位置
    - `Command` = `Windows` 、`Option = Alt`
- `Config.plist`
  - 移除 `AppleLPC` 仿冒属性 , 电源键功能由 `SSDT-PMCR.aml` 取代
  - 移除关于屏蔽 `AppleIntelLpssI2C` 的属性 , 不再需要
  - 由于用回早期亮度调整快捷键补丁 `SSDT-BKEY.aml`  , 添加相关更名
# Air13IWL-OC-1.1.0
- 更新 OpenCore 版本至 0.5.0
- 更新驱动至最新 Releases 版
- 添加文件保险箱功能的相关驱动
# 启用以 Releases 版本号为基础的更新日志
# 2019-09-05
- 从 `SSDT-AIR13IWL.aml` 中分离并移除 `FakePCIID_Intel_HDMI_Audio.kext` , 移除 `FakePCIID.kext` 
- 更新 `小兵` 新编译的 `AppleALC.kext` 添加 HDMI 音频支持 , 相关修改已提交至 `AppleALC.kext` 项目
- 随着 `WhateverGreen.kext` 的更新 , 移除显卡部分不再需要的属性
# 2019-08-30
- 合并 `SSDT-TPXX.aml` 至 `SSDT-AIR13IWL.aml`
- 移除 `SSDT-RMCFMap.aml` , 修改驱动 `VoodooPS2Controller.kext` 内的 `VoodooPS2Keyboard.kext` PS2 键盘驱动实现下列功能
  - 屏蔽错误的亮度快捷键 `Fn + K`、`Fn + P`
  - 添加 `Fn+F4` =上一曲
  - 添加 `Fn+F7` =下一曲
  - 添加 `PrtSc` = 播放/暂停
  - 添加 `Fn+F11` = 亮度减少
  - 添加 `Fn+F12` = 亮度增加
  - 关闭 `Command` 、`Option` 交换位置选项
# 2019-08-20
- 移除操作系统更名 , 移除亮度快捷键更名及其相关补丁
- 使用 `SSDT-RMCFMap.aml` 定制 PS2 键盘 , 屏蔽无用键 , 新增功能键
    - Fn + F4 = 上一曲
    - Fn + F7 = 下一曲
    - PrtSc = 播放 / 暂停
- 由于移除操作系统更名 , 使用 `SSDT-TPXX.aml` 驱动触摸板
# 2019-08-13
- 更新 `宪武` 大佬最新 `GPRW` 补丁 , 合并至 `SSDT-Air13IWL.aml`
# 2019-08-12
- 更新 `Acidanthera` 所有引导 , 驱动 , 工具至 Releases 版
# 2019-08-10
- 更新 OpenCore 至 0.0.4 版本 , 更新对应版本 `Config.plist`
- 更新 `EFI` - `OC` - `Drivers` 驱动 , 移除 `AptioMemoryFix.efi` , 增加 `FwRuntimeServices.efi`
- 更新 `EFI` - `OC` - `Tools` 工具
- 默认打开 `BrcmFirmwareData.kext` 、`BrcmPatchRAM2.kext`( `DW1820A` 蓝牙驱动 ) 此驱动经过修改只适合 ID : `0a5c_6412`使用
# 2019-08-05
- 移除所有更名的限制查找条件以保证不同版本 BIOS 的通用性
# 2019-08-04
- 移除 `SSDT-Air13IWL.aml` 中的 `OCOS` 补丁
- 添加 `宪武` 大佬最新 `Windows 2018 to Darwin` 操作系统更名
# 2019-08-03
- 移除声卡注入 `device-id` , 修改 `Air13IWL.kext` , 声卡驱动 `AppleALC.kext` 可单独使用不在受 `FakePCIID.kext` 和 `FakePCIID_Intel_HDMI_Audio.kext` 影响 , 使用HDMI音频仍需 `FakePCIID.kext`
- 参考 `宪武` 大佬关于 `AptioMemoryFix.efi` 正确使用方式 , 默认打开 `Config.plist` - `Kernel` - `Quirks` - `DisableIoMapper` , 同时建议在隐藏BIOS禁用 `CFG Lock`
- 添加启动项 `Verify MsrE2` 可查看 MsrE2 ( CFG Lock ) 锁定解锁状态
- 移除部分驱动内的非必要文件 , 移除 `Config.plist `-` NVRAM `-` LegacySchema` 下内容
# 2019-07-27
- 合并更新 `SSDT-Air13IWL.aml` 、`SSDT-GPRW.aml`
- 从 `Air13IWL.kext` 中分离 `BrcmBluetoothInjector.kext`
- 补全部分更名参数
- 添加启动工具 `UEFI Shell` 和 `Clean Nvram`
- 补全部分 NVRAM 为 OC 官方推荐项
# 2019-07-25
- 添加部分 NVRAM 参数
- 上传完整 EFI 目录方便单系统用户直接替换
# 2019-07-17
- 添加 `GPRW to XPRW` 更名 , `0D/6D` 补丁 , 暂时性解决睡眠秒醒问题
- 更新配置文件 : 默认打开所有设备引导扫描,如需关闭修改 `Config.plist` - `Misc` - `Security` - `ScanPolicy` 为 `983299`
# 2019-07-15
- 使用 OpenCore - 0.0.3 - Releases
- 使用前先补全 `Config.plist` - `PlatformInfo` - `Generic` 下的空白内容
- 已更换 `DW1820A` 蓝牙ID为 `0a5c` : `6412` 的可以直接使用 (仍需配合虚拟机大法)
- 目前已知问题 : 插入 USB 设备时会有睡眠秒醒问题 , 添加 `0d/6d` 补丁可解决
- 整合 `SSDT-OCOS.aml` 、`SSDT-XCPM.aml` 、`SSDT-PNLF.aml` 、`SSDT-SBUS.aml` 、`SSDT-EC.aml` 、`SSDT-Q11Q12.aml` 合并为 `SSDT-Air13IWL.aml`
- 整合 `CPUFriendDataProvider.kext` 、`FakePCIID_Intel_HDMI_Audio.kext` 、`XHCI-unsupported.kext` 、`USBPorts.kext` 、`BrcmBluetoothInjector.kext` 合并为 `Air13IWL.kext`