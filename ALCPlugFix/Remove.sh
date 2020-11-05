#!/bin/bash

sudo launchctl unload /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/LaunchDaemons/com.black-dragon74.ALCPlugFix.plist
sudo rm /usr/local/bin/ALCPlugFix
sudo rm /usr/local/bin/alc-verb
sudo rm -r /Library/Preferences/ALCPlugFix

echo Done !
