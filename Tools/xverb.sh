#!/bin/sh

#  xverb.sh

#  Additional features: Automatically turn off Bluetooth during sleep and automatically turn on Bluetooth upon wake-up

#  Created by xlivans on 2024/1/20.

echo
echo " xverb"
echo
echo "     1. 安装 Install"
echo "     2. 卸载 Removed"
echo
read -p "选择 Select : " iu

case ${iu} in
    1) echo "安装 Install ..."
    ;;
    2) echo "卸载 Removed ..."
        sudo rm -rf /Library/LaunchDaemons/com.xlivans.xverb.plist
        sudo rm -rf /usr/local/bin/xverb
        echo "完成 Done !"
        exit
    ;;
    *) echo "选择错误 Selection Error !"
        echo "已退出 Exited !"
        exit
    ;;
esac

if [[ ! -d /usr/local/bin ]]; then
    sudo mkdir -p /usr/local/bin
fi

if [[ ! -f xverb ]]; then
    curl -O https://gitee.com/xlivans/Air13IWL/raw/master/Tools/xverb
fi

if [[ ! -f xverb ]]; then
    echo "xverb 不存在或下载失败 xverb Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

sudo cp xverb /usr/local/bin
sudo chmod 755 /usr/local/bin/xverb
sudo chown root:wheel /usr/local/bin/xverb
sudo spctl --add /usr/local/bin/xverb

cat > "com.xlivans.xverb.plist" <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>com.xlivans.xverb</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/xverb</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
</dict>
</plist>
CCC

sudo cp com.xlivans.xverb.plist /Library/LaunchDaemons
sudo chmod 644 /Library/LaunchDaemons/com.xlivans.xverb.plist
sudo chown root:wheel /Library/LaunchDaemons/com.xlivans.xverb.plist

sudo rm -rf xverb
sudo rm -rf com.xlivans.xverb.plist

echo "完成 Done !"
exit
