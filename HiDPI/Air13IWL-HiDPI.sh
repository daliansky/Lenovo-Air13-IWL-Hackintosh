#!/bin/sh

#  Air13IWL-HiDPI.sh
#  Enable HiDPI For Air13IWL
#  For macOS Big Sur 11 / Catalina 10.15
#  Created by xlivans on 2020/12/10.

echo
echo "   Air13IWL 开启 HiDPI"
echo
echo "     1. 安装 Install"
echo "     2. 卸载 Removed"
echo
read -p "选择 Select : " iu

case ${iu} in
    1) echo "安装 Install ..."
    ;;
    2) echo "卸载 Removed ..."
        sudo rm -rf /Library/Displays
        echo "完成 Done !"
        exit
    ;;
    *) echo "选择错误 Selection Error !"
        echo "已退出 Exited !"
        exit
    ;;
esac

edid=($(ioreg -lw0 | grep -i "IODisplayEDID" | sed -e "/[^<]*</s///" -e "s/\>//"))
vid=${edid:16:4}
pid=${edid:22:2}${edid:20:2}
if [ ${vid:0:1} == 0 ]; then
    vid=${vid:1:3}
fi

if [ ${pid:0:1} == 0 ]; then
    pid=${vid:1:3}
fi
xvid=$((16#${vid}))
xpid=$((16#${pid}))
dpid=DisplayProductID-${pid}
dvid=DisplayVendorID-${vid}

cat > ${dpid} <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>DisplayProductID</key>
        <integer>PID</integer>
    <key>DisplayVendorID</key>
        <integer>VID</integer>
    <key>scale-resolutions</key>
        <array>
            <data>AAAMgAAABwgA</data>
            <data>AAALQAAABlQA</data>
            <data>AAAKAAAABaAA</data>
        </array>
    <key>target-default-ppmm</key>
        <real>10.0699301</real>
</dict>
</plist>
CCC

sed -i "" "s/VID/${xvid}/g" ${dpid}
sed -i "" "s/PID/${xpid}/g" ${dpid}

cat > "Icons.plist" <<-\CCC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>vendors</key>
    <dict>
        <key>VID</key>
        <dict>
            <key>products</key>
            <dict>
                <key>PID</key>
                <dict>
                    <key>display-resolution-preview-icon</key>
                    <string>/System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-610/DisplayProductID-a030-e1e1df.tiff</string>
                    <key>resolution-preview-x</key>
                    <integer>40</integer>
                    <key>resolution-preview-y</key>
                    <integer>62</integer>
                    <key>resolution-preview-width</key>
                    <integer>147</integer>
                    <key>resolution-preview-height</key>
                    <integer>92</integer>
                </dict>
            </dict>
        </dict>
    </dict>
</dict>
</plist>
CCC
sed -i "" "s/VID/${vid}/g" Icons.plist
sed -i "" "s/PID/${pid}/g" Icons.plist

sudo mkdir -p /Library/Displays/Contents/Resources/Overrides/${dvid}
sudo cp ${dpid} /Library/Displays/Contents/Resources/Overrides/${dvid}
sudo cp Icons.plist /Library/Displays/Contents/Resources/Overrides
sudo chmod 644 /Library/Displays/Contents/Resources/Overrides/${dvid}/${dpid}
sudo chown root:wheel /Library/Displays/Contents/Resources/Overrides/${dvid}/${dpid}
sudo chmod 644 /Library/Displays/Contents/Resources/Overrides/Icons.plist
sudo chown root:wheel /Library/Displays/Contents/Resources/Overrides/Icons.plist
sudo rm -rf ${dpid}
sudo rm -rf Icons.plist
echo "完成 Done !"
exit
