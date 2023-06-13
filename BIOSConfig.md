## 联想小新 Air13IWL 隐藏BIOS开启及设置建议
BIOS 发布时间 : 2021-01-25 , BIOS 版本 : [9RCN28WW ( V2.08 )](https://newsupport.lenovo.com.cn/driveDownloads_detail.html?driveId=78529) 

- 常规 BIOS 设置建议
  - `Configuration`
    - `Wireless LAN` → `Enabled` ( 内置 WiFi 网卡)
    - `Power Beep` → `Enabled` ( 电源提示音 )
    - `Intel Virtual Technology` → `Enabled` ( 因特尔虚拟化技术 )
    - `Intel(R) Hyper-Threading Technology` → `Enabled` ( 因特尔超线程技术 ) 
    - `BIOS Back Flash` → `Disabled` ( BIOS 版本降级时启用 )
    - `HotKey Mode` → `Disabled` ( `F1-F2`功能键 , 关闭时使用 `Fn`+`F1-F12`控制声音亮度等功能 ，根据使用习惯设置 )
    - `Fool Proof Fn Ctrl` → `Disabled` ( `Fn`键和`Ctrl`键防呆设置 , 使用某些常用快捷键时 , 可将`Fn`视作`Ctrl`键使用 )
    - `Always On USB` → `Disabled` ( 电源供电时 , 关机或休眠后 USB 保持供电 )
    - `Charge in Battery Mode` → `Disabled` ( 电池供电时 , 关机或休眠后 USB 保持供电 )
    - `System Performance Mode` → `Intelligent` ( 系统性能模式 )
    - `Storage` ( 存储 )
      - `Controller Mode` → `AHCI mode`  ( 存储控制器工作模式 )
  - `Security`
    - `Intel Platform Trust Technology` → `Enabled` ( `TPM2.0` , 关闭时影响 Windows 11 系统更新和安装 )
    - `Intel (R) SGX` ( 英特尔软件安全扩展 )
      - `Intel (R) SGX Control` → `Enabled` ( 英特尔软件安全扩展 , 使用其他选项时 Windows 指纹识别将不可用 )
    - `Secure Boot` → `Disabled`( 安全启动 )
  - `Power`
    - `Wake on PME` → `Disabled` ( 网络唤醒 )
    - `Wake on Modem Ring` → `Disabled` ( 调制解调器振铃唤醒 )
    - `Auto Wake on S5` → `Disabled` ( `S5`自动唤醒 )
    - `S5 Long Run Test` → `Disabled` ( `S5`长期运行试验 )
  - `Boot`
    - `Boot Mode` → `UEFI` ( 仅`UEFI`启动模式 )
    - `USB Boot` → `Enabled` ( 从`USB`设备启动 )
    - `PXE Boot to LAN` → `Disabled` (`网络启动`)
- 隐藏 BIOS 进入方法
  - 电源键开机 → F2进入正常BIOS → 电源键关机 → 然后顺序按下下列键
  - `F1` → `1` → `Q` → `A` → `Z`
  - `F2` → `2` → `W` → `S` → `X`
  - `F3` → `3` → `E` → `D` → `C`
  - `F4` → `4` → `R` → `F` → `V`
  - `F5` → `5` → `T` → `G` → `B`
  - `F6` → `6` → `Y` → `H` → `N`
  - 电源键开机 → F2进入隐藏BIOS , 如不成功请加快手速再次尝试
- 隐藏 BIOS 强烈推荐设置
  - 关闭 CFG Lock ( MSR 0xE2 )
    - `Advanced` → `Power & Performance` → `CPU - Power Management Control` → `CPU Lock Configuration` → `CFG Lock` → `Disabled`
  - 修改 DVMT 为 64M
    - `Advanced` → `System Agent (SA) Configuration` → `Graphics Configuration` → `DVMT Pre-Allocated` → `64M`
  - 使用苹果拆机卡 `BCM94360CS2` / `BCM943602CS` 时关闭网卡接口的`ASPM`
    - `Advanced` → `PCH-IO Configuration` → `PCI Express Configuration` → `PCI Express Root Port 8` → `ASPM 7` → `Disabled`
- 隐藏 BIOS 非必要设置
  - 调整 CPU 基础频率使其更接近`MacBookPro15,4`的CPU参数
    - `Advanced` → `CPU Configuration` → `CPU Flex Ratio Override` → `Enabled`
    - `Advanced` → `CPU Configuration` → `CPU Flex Ratio Setting` → `14` (i5设置14 , i7设置17)
  - 调整内存最大频率使其更接近`MacBookPro15,4`的内存参数
    - `Advanced` → `Memory Configuration` → `Maximum Memory Frequency` → `2133`
  - 关闭无用的 PCI Express 端口 ( 以我核显版为例 , 8是WiFi网卡 , 9是硬盘 , 可关闭 7 和 13 (其中一个可能是独显 , 根据实际需求选择性设置))
    - `Advanced` → `PCH-IO Configuration` → `PCI Express Configuration` → `PCI Express Root Port 7` → `PCI Express Root Port 7` → `Disabled`
    - `Advanced` → `PCH-IO Configuration` → `PCI Express Configuration` → `PCI Express Root Port 13` → `PCI Express Root Port 13` → `Disabled`
  - 关闭无用的 I2C 端口 (以我为例 `I2C0` 是触摸板 , 其他 xxx `Controller` 都可以关闭)
    - `Advanced` → `PCH-IO Configuration` → `Seriallo Configuration` → `I2C1 Controller` → `Disabled`
    



