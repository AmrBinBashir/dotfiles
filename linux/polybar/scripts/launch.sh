#!/usr/bin/env bash

DIR="~/.config/polybar/docky"

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -q main -c "$DIR"/config.ini &
