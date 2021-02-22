#!/bin/bash

lxsession &
picom &
dunst &
discord --start-minimized &
. ~/.fehbg &
sxhkd &
nm-applet &
xinput set-prop "SynPS/2 Synaptics TouchPad" 339 1 &
xinput set-prop "SynPS/2 Synaptics TouchPad" 319 1 &