# Air13IWL OpenCore 启动磁盘 切换系统的使用

- 使用环境 
  - Windows 10 和 Catalina 单硬盘双系统
  - MacOS 下的 Windows 系统分区为挂载状态
  - 使用 OC 做主引导 , 双系统共用单 ESP 分区 
  - 使用 OC 引导启动 Windows 10 安装苹果官方的 BootCamp
    - MacOS下打开 APP **启动转换助理** , `菜单栏 - 操作 - 下载 Windows 支持软件` 按提示操作即可下载最新 Windows 版支持软件 , 其中包含 BootCamp
- Config.plist 
  - Misc
    - BlessOverride  ( 覆盖替换掉 Windows 的 BOOTx64.efi 情况下, 需要在此指定 Windows 引导 )
      - `Item0		<String>	\EFI\Microsoft\Boot\bootmgfw.efi`
    - Security
      - `ExposeSensitiveData		<Number>	2 `
      - `ScanPolicy		<Number>	525571 `   ( 自定义必须包含 ESP , 例 : NVME + APFS + ESP )
  - UEFI
    - Quirks
      - `RequestBootVarRouting		<Boolean>		YES`
