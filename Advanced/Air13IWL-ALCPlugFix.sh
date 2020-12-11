#!/bin/sh

#  Air13IWL-ALCPlugFix.sh
#  Enable Combo Jack Mic Detection For Air13IWL
#  For alc-verb On AppleALC
#  Created by xlivans on 2020/12/10.

echo
echo " ALCPlugFix For Air13IWL"
echo
echo "     1. 安装 Install"
echo "     2. 卸载 Removed"
echo
read -p "选择 Select : " iu

case ${iu} in
    1) echo "安装 Install ..."
    ;;
    2) echo "卸载 Removed ..."
        sudo launchctl unload /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
        sudo rm -rf /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
        sudo rm -rf /usr/local/bin/ALCPlugFix
        sudo rm -rf /usr/local/bin/alc-verb
        sudo rm -rf /Library/Preferences/ALCPlugFix
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

if [[ ! -f alc-verb ]]; then
    curl -O https://gitee.com/xlivans/Tools/raw/master/alc-verb
fi

if [[ ! -f ALCPlugFix ]]; then
    curl -O https://gitee.com/xlivans/Tools/raw/master/ALCPlugFix
fi

if [[ ! -f alc-verb ]]; then
    echo "alc-verb 不存在或下载失败 alc-verb Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

if [[ ! -f ALCPlugFix ]]; then
    echo "ALCPlugFix 不存在或下载失败 ALCPlugFix Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

sudo cp alc-verb /usr/local/bin
sudo chmod 755 /usr/local/bin/alc-verb
sudo chown root:wheel /usr/local/bin/alc-verb

sudo cp ALCPlugFix /usr/local/bin
sudo chmod 755 /usr/local/bin/ALCPlugFix
sudo chown root:wheel /usr/local/bin/ALCPlugFix

if [[ ! -d /Library/Preferences/ALCPlugFix ]]; then
    sudo mkdir -p /Library/Preferences/ALCPlugFix
fi

cat > "com.black-dragon74.ALCPlugFix.plist" <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>com.black-dragon74.ALCPlugFix</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/ALCPlugFix</string>
        <string>/Library/Preferences/ALCPlugFix/Config.plist</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
</dict>
</plist>
CCC

cat > "Config.plist" <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
    <dict>
        <key>Comment</key>
        <string>Enable combo jack mic detection</string>
        <key>Enabled</key>
        <true/>
        <key>Node ID</key>
        <string>0x19</string>
        <key>On Boot</key>
        <true/>
        <key>On Connect</key>
        <true/>
        <key>On Disconnect</key>
        <false/>
        <key>On Mute</key>
        <false/>
        <key>On Sleep</key>
        <false/>
        <key>On Unmute</key>
        <false/>
        <key>On Wake</key>
        <true/>
        <key>Param</key>
        <string>0x25</string>
        <key>Verb</key>
        <string>SET_PIN_WIDGET_CONTROL</string>
    </dict>
</array>
</plist>
CCC

sudo cp Config.plist /Library/Preferences/ALCPlugFix
sudo chmod 644 /Library/Preferences/ALCPlugFix/Config.plist
sudo chown root:wheel /Library/Preferences/ALCPlugFix/Config.plist

sudo cp com.black-dragon74.ALCPlugFix.plist /Library/LaunchAgents
sudo chmod 644 /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo launchctl load /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist

sudo rm -rf alc-verb
sudo rm -rf ALCPlugFix
sudo rm -rf Config.plist
sudo rm -rf com.black-dragon74.ALCPlugFix.plist

echo "完成 Done !"
exit
