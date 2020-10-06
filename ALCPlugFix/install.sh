#!/bin/bash

path=${0%/*}
sudo cp -f "$path/ALCPlugFix" /usr/local/bin
sudo chmod 755 /usr/local/bin/ALCPlugFix
sudo chown root:wheel /usr/local/bin/ALCPlugFix
sudo cp -f "$path/hda-verb" /usr/local/bin
sudo chmod 755 /usr/local/bin/hda-verb
sudo chown root:wheel /usr/local/bin/hda-verb
sudo cp -f "$path/good.win.ALCPlugFix.plist" /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo launchctl load -w /Library/LaunchDaemons/good.win.ALCPlugFix.plist
