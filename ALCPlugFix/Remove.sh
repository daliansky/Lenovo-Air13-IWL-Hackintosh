#!/bin/bash

sudo rm /usr/local/bin/ALCPlugFix
sudo rm /usr/local/bin/hda-verb
sudo launchctl unload -w /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo launchctl remove /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo rm /Library/LaunchDaemons/good.win.ALCPlugFix.plist
