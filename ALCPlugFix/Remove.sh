#!/bin/bash

sudo launchctl unload /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /usr/local/bin/ALCPlugFix
sudo rm /usr/local/bin/alc-verb
sudo rm -r /Library/Preferences/ALCPlugFix

echo Done !
