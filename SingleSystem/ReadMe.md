# Air13IWL OpenCore 单系统建议

- ACPI
  - 移除 SSDT-OSYS.aml
  - 移除 SSDT-BKEY.aml
  - 替换 [SSDT-RMCF.aml](SSDT-RMCF.aml)

- Config.plist - ACPI - Patch
  - 移除 Windows to Xindows 更名
  - 移除 _Q11 to XQ11 更名
  - 移除 _Q12 to XQ12 更名