#!/bin/bash

cd ~/desktop/
curl -O https://raw.githubusercontent.com/acidanthera/CPUFriend/master/Tools/ResourceConverter.sh
chmod +x ~/desktop/ResourceConverter.sh
~/desktop/ResourceConverter.sh --kext ~/desktop/CPU.plist
rm ~/desktop/ResourceConverter.sh
rm ~/desktop/CPU.plist
rm ~/desktop/freqVectorsEdit.sh
