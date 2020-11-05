#!/bin/bash

path=${0%/*}

sudo launchctl unload /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo launchctl unload /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo launchctl unload /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo launchctl unload /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo rm /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo rm /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist
sudo rm /usr/local/bin/ALCPlugFix
sudo rm /usr/local/bin/alc-verb
sudo rm /usr/local/bin/hda-verb
sudo rm -r /Library/Preferences/ALCPlugFix
sudo rm -r /Library/Logs/ALCPlugFix

sudo mkdir /usr/local/bin
sudo mkdir /Library/Preferences/ALCPlugFix

sudo cp "$path/alc-verb" /usr/local/bin
sudo chmod 755 /usr/local/bin/alc-verb
sudo chown root:wheel /usr/local/bin/alc-verb

sudo cp "$path/ALCPlugFix" /usr/local/bin
sudo chmod 755 /usr/local/bin/ALCPlugFix
sudo chown root:wheel /usr/local/bin/ALCPlugFix

sudo cp "$path/Config.plist" /Library/Preferences/ALCPlugFix
sudo chmod 644 /Library/Preferences/ALCPlugFix/Config.plist
sudo chown root:wheel /Library/Preferences/ALCPlugFix/Config.plist

sudo cp "$path/com.black-dragon74.ALCPlugFix.plist" /Library/LaunchDaemons
sudo chmod 644 /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist
sudo launchctl load /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist

echo Done !
