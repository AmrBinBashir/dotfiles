#!/usr/bin/env bash


lxsession &
picom &
dunst &
discord --start-minimized &
. ~/.fehbg &
sxhkd &
nm-applet &
xinput set-prop "SynPS/2 Synaptics TouchPad" $(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Natural Scrolling Enabled" | awk -F'[()]' 'NR==1 {print $(NF-1)}' ) 1 &
xinput set-prop "SynPS/2 Synaptics TouchPad" $(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "Tapping Enabled" | awk -F'[()]' 'NR==1 {print $(NF-1)}' ) 1 &
sh ~/.config/polybar/scripts/launch.sh &
spotify-tray -m &
volctl &
mailspring -b &
