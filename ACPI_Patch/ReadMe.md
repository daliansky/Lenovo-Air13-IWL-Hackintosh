# HotPatch

## 简介

- OpenCore使用的`SSDT-AIR13IWL.aml` 由下列补丁合并而来
  - `SSDT-PNLF.dsl` : CFL定制亮度补丁
  - `SSDT-SBUS.dsl` : SMBus系统管理总线补丁
  - `SSDT-GPRW.dsl` : USB(0d/6d)断电补丁
  - `SSDT-XCPM.dsl` : CPU电源管理补丁
  - `SSDT-TPXX.dsl` : I2C触摸板轮询补丁
  - `SSDT-EC.dsl` : EC仿冒补丁
- Clover使用的`SSDT-AIR13IWL.aml` 由下列补丁合并而来
  - `SSDT-PNLF.dsl` : CFL定制亮度补丁
  - `SSDT-SBUS.dsl` : SMBus系统管理总线补丁
  - `SSDT-XOSI.dsl` : 操作系统补丁
  - `SSDT-GPRW.dsl` : USB(0d/6d)断电补丁
  - `SSDT-XCPM.dsl` : CPU电源管理补丁
  - `SSDT-EC.dsl` : EC仿冒补丁
  - `SSDT-Q11Q12.dsl` : 亮度快捷键补丁

## 鸣谢

- 感谢`宪武`提供的所有补丁。 