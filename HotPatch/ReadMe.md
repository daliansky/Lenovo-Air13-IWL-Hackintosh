# HotPatch
## 简介
| 补丁                       | 说明                              | 必备 | 建议 | 可选 |
| -------------------------- | --------------------------------- | ---- | ---- | ---- |
| [SSDT-GPRW](SSDT-GPRW.dsl) | 0D / 6D 睡了即醒补丁              |      | √    |      |
| [SSDT-HPTE](SSDT-HPTE.dsl) | 屏蔽 HPET 补丁                    |      |      | √    |
| [SSDT-USBX](SSDT-USBX.dsl) | USB 电源补丁                      | √    |      |      |
| [SSDT-PNLF](SSDT-PNLF.dsl) | Coffee Lake 亮度控制补丁          | √    |      |      |
| [SSDT-SLPB](SSDT-SLPB.dsl) | 仿冒 PNP0C0E 设备                 |      |      | √    |
| [SSDT-MCHC](SSDT-MCHC.dsl) | 仿冒 MCHC 设备                    |      | √    |      |
| [SSDT-XSPI](SSDT-XSPI.dsl) | 仿冒 XSPI 设备                    |      |      | √    |
| [SSDT-LPAD](SSDT-LPAD.dsl) | I2C 触摸板补丁                    |      |      | √    |
| [SSDT-DMAC](SSDT-DMAC.dsl) | 仿冒 DMA 控制器                   |      |      | √    |
| [SSDT-EC](SSDT-EC.dsl)     | 仿冒 EC 设备                      | √    |      |      |
| [SSDT-PMCR](SSDT-PMCR.dsl) | 仿冒 PCHPMC 设备                  | √    |      |      |
| [SSDT-SBUS](SSDT-SBUS.dsl) | 仿冒 BUS0 , DVL0 设备             |      |      | √    |
| [SSDT-PR00](SSDT-PR00.dsl) | CPU 电源管理补丁 ( 开启XCPM )     | √    |      |      |
| [SSDT-RMCF](SSDT-RMCF.dsl) | PS2 按键映射补丁                  |      | √    |      |
| [SSDT-OSYS](SSDT-OSYS.dsl) | 操作系统补丁 ( 电池充电状态同步 ) | √    |      |      |
- **必备** : 影响各个部件的功能使用 , 开启
- **建议** : 兼容性补丁 , 非必要 , 建议开启
- **可选** : 只是一种完善方案 , 非必要 , 默认关闭 , 可自行选择是否开启
- **操作系统补丁** 的关闭会导致 Windows 设置的 **电池养护模式** 和 **触摸板** 关闭 , 如需关闭可做如下调整 : 关闭`OSYS`补丁并打开`LPAD`补丁以启用触摸板
  - `Config.plist` - `ACPI` - `Add` - `OSYS` : `Enabled` - `NO`
  - `Config.plist` - `ACPI` - `Add` - `LPAD` : `Enabled` - `YES`

## 鸣谢

- **宪武** 提供 [OC-little](https://github.com/daliansky/OC-little)