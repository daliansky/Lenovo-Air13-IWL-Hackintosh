#!/bin/bash

path=${0%/*}
sudo mount -uw / && killall Finder
sudo launchctl remove /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo rm -rf /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo rm -rf /usr/bin/ALCPlugFix
sudo rm -rf /usr/bin/hda-verb
