#!/bin/bash
gDisplayInf=($(ioreg -lw0 | grep -i "IODisplayEDID" | sed -e "/[^<]*</s///" -e "s/\>//"))
gMonitor=${gDisplayInf}

if [[ ${gMonitor:16:1} == 0 ]]; then
    gDisplayVendorID_RAW=${gMonitor:17:3}
else
    gDisplayVendorID_RAW=${gMonitor:16:4}
fi

gDisplayVendorID=$((0x$gDisplayVendorID_RAW))
gDisplayProductID_RAW=${gMonitor:20:4}

if [[ ${gDisplayProductID_RAW:2:1} == 0 ]]; then
    gDisplayProduct_pr=${gDisplayProductID_RAW:3:1}
else
    gDisplayProduct_pr=${gDisplayProductID_RAW:2:2}
fi
    
gDisplayProduct_st=${gDisplayProductID_RAW:0:2}
gDisplayProductID_reverse="${gDisplayProduct_pr}${gDisplayProduct_st}"
gDisplayProductID=$((0x$gDisplayProduct_pr$gDisplayProduct_st))

EDID=$gMonitor
VendorID=$gDisplayVendorID
ProductID=$gDisplayProductID 
Vid=$gDisplayVendorID_RAW
Pid=$gDisplayProductID_reverse 

cat > "DisplayProductID-$Pid" <<-\CCC
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

sed -i "" "s/VID/$VendorID/g" DisplayProductID-$Pid
sed -i "" "s/PID/$ProductID/g" DisplayProductID-$Pid

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
sed -i "" "s/VID/$Vid/g" Icons.plist
sed -i "" "s/PID/$Pid/g" Icons.plist

sudo mkdir rm -rf /Library/Displays
sudo mkdir /Library/Displays
sudo mkdir /Library/Displays/Contents
sudo mkdir /Library/Displays/Contents/Resources
sudo mkdir /Library/Displays/Contents/Resources/Overrides
sudo mkdir /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-$Vid
sudo cp DisplayProductID-$Pid /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-$Vid
sudo cp Icons.plist /Library/Displays/Contents/Resources/Overrides
echo Done !
