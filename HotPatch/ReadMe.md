# HotPatch
## 简介
| 补丁                       | 说明                                     | 必备 | 建议 | 可选 |
| -------------------------- | ---------------------------------------- | ---- | ---- | ---- |
| [SSDT-GPRW](SSDT-GPRW.dsl) | 0D / 6D 睡了即醒（USB 断电）补丁         | √    |      |      |
| [SSDT-HPTE](SSDT-HPTE.dsl) | 屏蔽 HPET 补丁                           |      |      | √    |
| [SSDT-PNLF](SSDT-PNLF.dsl) | Coffee Lake 亮度控制补丁                 | √    |      |      |
| [SSDT-SLPB](SSDT-SLPB.dsl) | 仿冒 PNP0C0E 设备                        |      |      | √    |
| [SSDT-MCHC](SSDT-MCHC.dsl) | 仿冒 MCHC 设备                           |      | √    |      |
| [SSDT-XSPI](SSDT-XSPI.dsl) | 仿冒 XSPI 设备                           |      |      | √    |
| [SSDT-PPMC](SSDT-PPMC.dsl) | 仿冒 PPMC 设备                           |      |      | √    |
| [SSDT-LPAD](SSDT-LPAD.dsl) | I2C 触摸板补丁                           | √    |      |      |
| [SSDT-DMAC](SSDT-DMAC.dsl) | 仿冒 DMA 控制器                          |      |      | √    |
| [SSDT-EC](SSDT-EC.dsl)     | 仿冒 EC 设备                             | √    |      |      |
| [SSDT-PMCR](SSDT-PMCR.dsl) | 仿冒 PCHPMC 设备                         |      | √    |      |
| [SSDT-SBUS](SSDT-SBUS.dsl) | 仿冒 BUS0 , DVL0 设备                    |      | √    |      |
| [SSDT-PR00](SSDT-PR00.dsl) | CPU 电源管理补丁 ( 开启XCPM )            | √    |      |      |
| [SSDT-RMCF](SSDT-RMCF.dsl) | PS2 按键映射补丁                         |      | √    |      |
| [SSDT-OSYS](SSDT-OSYS.dsl) | 操作系统定义补丁 ( 电池充电状态同步 )    |      |      | √    |
| [SSDT-BKEY](SSDT-BKEY.dsl) | 亮度快捷键补丁 ( 使用 SSDT-OSYS 时使用 ) |      |      | √    |
## 鸣谢
- **宪武** 提供 [OC-little](https://github.com/daliansky/OC-little)