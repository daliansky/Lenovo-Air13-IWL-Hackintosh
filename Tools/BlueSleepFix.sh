#!/bin/sh

echo
echo " BlueSleepFix For Air13IWL"
echo
echo "     1. 安装 Install"
echo "     2. 卸载 Removed"
echo
read -p "选择 Select : " iu

case ${iu} in
    1) echo "安装 Install ..."
    ;;
    2) echo "卸载 Removed ..."
        sudo rm -rf ~/Library/LaunchAgents/homebrew.mxcl.sleepwatcher.plist
        sudo rm -rf /usr/local/bin/blueutil
        sudo rm -rf /usr/local/sbin/sleepwatcher
        sudo rm -rf ~/.sleep
        sudo rm -rf ~/.wakeup
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

if [[ ! -f blueutil ]]; then
    curl -O https://gitee.com/xlivans/Air13IWL/raw/master/Tools/blueutil
fi

if [[ ! -f sleepwatcher ]]; then
    curl -O https://gitee.com/xlivans/Air13IWL/raw/master/Tools/sleepwatcher
fi

if [[ ! -f blueutil ]]; then
    echo "blueutil 不存在或下载失败 blueutil Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

if [[ ! -f sleepwatcher ]]; then
    echo "sleepwatcher 不存在或下载失败 sleepwatcher Does Not Exist Or Download Failed !"
    echo "已退出 Exited !"
    exit
fi

if [[ ! -d /usr/local/bin ]]; then
    sudo mkdir -p /usr/local/bin
fi

if [[ ! -d /usr/local/sbin ]]; then
    sudo mkdir -p /usr/local/sbin
fi

sudo cp blueutil /usr/local/bin
sudo chmod 755 /usr/local/bin/blueutil
sudo chown root:wheel /usr/local/bin/blueutil
sudo spctl --add /usr/local/bin/blueutil

sudo cp sleepwatcher /usr/local/sbin
sudo chmod 755 /usr/local/sbin/sleepwatcher
sudo chown root:wheel /usr/local/sbin/sleepwatcher
sudo spctl --add /usr/local/sbin/sleepwatcher

cat > "homebrew.mxcl.sleepwatcher.plist" <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>homebrew.mxcl.sleepwatcher</string>
    <key>LimitLoadToSessionType</key>
    <array>
        <string>Aqua</string>
        <string>Background</string>
        <string>LoginWindow</string>
        <string>StandardIO</string>
        <string>System</string>
    </array>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/sbin/sleepwatcher</string>
        <string>-V</string>
        <string>-s</string>
        <string>/Users/xlivans/.sleep</string>
        <string>-w</string>
        <string>/Users/xlivans/.wakeup</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
CCC

sed -i "" "s/xlivans/$USER/g" homebrew.mxcl.sleepwatcher.plist

cat > ".sleep" <<-\CCC
/usr/local/bin/blueutil --power 0
CCC

cat > ".wakeup" <<-\CCC
/usr/local/bin/blueutil --power 1
CCC

mv .sleep ~/
mv .wakeup ~/

sudo chmod 755 ~/.sleep
sudo chmod 755 ~/.wakeup

if [[ ! -d ~/Library/LaunchAgents ]]; then
    sudo mkdir -p ~/Library/LaunchAgents
fi

sudo cp homebrew.mxcl.sleepwatcher.plist ~/Library/LaunchAgents
sudo chmod 644 ~/Library/LaunchAgents/homebrew.mxcl.sleepwatcher.plist
sudo chown root:wheel ~/Library/LaunchAgents/homebrew.mxcl.sleepwatcher.plist

sudo rm -rf blueutil
sudo rm -rf sleepwatcher
sudo rm -rf homebrew.mxcl.sleepwatcher.plist

echo "完成 Done !"
exit
