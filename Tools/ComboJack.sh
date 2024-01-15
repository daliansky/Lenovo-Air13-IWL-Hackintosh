#!/bin/sh

#  ComboJack.sh
#  Enable Combo Jack Mic Detection For Dell Optiplex 7060 SFF
#  Created by xlivans on 2024/1/15.

echo
echo " ComboJack For Dell Optiplex 7060 SFF"
echo
echo "     1. 安装 Install"
echo "     2. 卸载 Removed"
echo
read -p "选择 Select : " iu

case ${iu} in
    1) echo "安装 Install ..."
    ;;
    2) echo "卸载 Removed ..."
        sudo rm -rf /Library/LaunchAgents/com.XPS.ComboJack.plist
        sudo rm -rf /usr/local/sbin/ComboJack
        sudo rm -rf /usr/local/share/ComboJack
        echo "完成 Done !"
        exit
    ;;
    *) echo "选择错误 Selection Error !"
        echo "已退出 Exited !"
        exit
    ;;
esac

if [[ ! -d /usr/local/sbin ]]; then
    sudo mkdir -p /usr/local/sbin
fi

if [[ ! -d /usr/local/share/ComboJack ]]; then
    sudo mkdir -p /usr/local/share/ComboJack
fi

if [[ ! -f ComboJack ]]; then
    curl -O https://gitee.com/xlivans/Air13IWL/raw/master/Tools/ComboJack
fi

if [[ ! -f ComboJack ]]; then
    echo "ComboJack 不存在或下载失败 ComboJack Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

if [[ ! -f Headphone.icns ]]; then
    curl -O https://gitee.com/xlivans/Air13IWL/raw/master/Tools/Headphone.icns
fi

if [[ ! -f Headphone.icns ]]; then
    echo "Headphone.icns 不存在或下载失败 Headphone.icns Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

sudo cp ComboJack /usr/local/sbin
sudo chmod 755 /usr/local/sbin/ComboJack
sudo chown root:wheel /usr/local/sbin/ComboJack
sudo spctl --add /usr/local/sbin/ComboJack

sudo cp Headphone.icns /usr/local/share/ComboJack
sudo chmod 644 /usr/local/share/ComboJack/Headphone.icns
sudo chown root:wheel /usr/local/share/ComboJack/Headphone.icns

cat > "com.XPS.ComboJack.plist" <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>com.XPS.ComboJack</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/sbin/ComboJack</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
</dict>
</plist>

CCC

cat > "l10n.json" <<-\CCC
{
    "zh_CN": {
        "dialogTitle" : "耳机接入通知",
        "dialogMsg" : "请选择接入的设备类型（按ESC键取消）",
        "btnHeadphone" : "耳机",
        "btnLinein" : "线路输入",
        "btnHeadset" : "耳麦",
        "btnCancel" : "取消"
    },
    "en_US": {
        "dialogTitle" : "Combo Jack Notification",
        "dialogMsg" : "What did you just plug in? (Press ESC to cancel)",
        "btnHeadphone" : "Headphones",
        "btnLinein" : "Line-In",
        "btnHeadset" : "Headset",
        "btnCancel" : "Cancel"
    },
    "ru_RU": {
        "dialogTitle" : "Combo Jack Notification",
        "dialogMsg" : "Какое устройство было подключено? (ESC для отмены)",
        "btnHeadphone" : "Наушники",
        "btnLinein" : "Линейный вход",
        "btnHeadset" : "Гарнитура",
        "btnCancel" : "Отмена"
    },
    "ru_UA": {
        "dialogTitle" : "Combo Jack Notification",
        "dialogMsg" : "Какое устройство было подключено? (ESC для отмены)",
        "btnHeadphone" : "Наушники",
        "btnLinein" : "Линейный вход",
        "btnHeadset" : "Гарнитура",
        "btnCancel" : "Отмена"
    },
    "uk_UA": {
        "dialogTitle" : "Combo Jack Notification",
        "dialogMsg" : "Який пристрій було підключено? (ESC для скасування)",
        "btnHeadphone" : "Навушники",
        "btnLinein" : "Лінійний вхід",
        "btnHeadset" : "Гарнітура",
        "btnCancel" : "Скасувати"
    }
}

CCC

sudo cp l10n.json /usr/local/share/ComboJack
sudo chmod 644 /usr/local/share/ComboJack/l10n.json
sudo chown root:wheel /usr/local/share/ComboJack/l10n.json

sudo cp com.XPS.ComboJack.plist /Library/LaunchAgents
sudo chmod 644 /Library/LaunchAgents/com.XPS.ComboJack.plist
sudo chown root:wheel /Library/LaunchAgents/com.XPS.ComboJack.plist

sudo rm -rf ComboJack
sudo rm -rf Headphone.icns
sudo rm -rf l10n.json
sudo rm -rf com.XPS.ComboJack.plist

echo "完成 Done !"
exit
