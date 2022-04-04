#!/bin/bash
st -t "Lock" -e bin/mission 1&
notify-send -t 500 "Lock" "Stopping Audio."
mute_all m
mic_mute m
volume
mpc stop
sleep 1

killall screenkey >> /dev/null 2>&1


if [ -n "$1" ]
then
    fn-f7-emergency.sh

    notify-send -t 500 "Lock" "Suspending"
    stop_syn.sh
    sleep 0.5 
    nmcli radio wifi on
    notify-send -t 500 "Lock" "Enabling wifi"
    sleep 2
    systemctl suspend
    asdf
fi

rm /tmp/screen.png
scrot /tmp/screen.png

notify-send -t 500 "Lock" "Locking screen."

#convert /tmp/screen.png -paint 3 -modulate 80 /tmp/screen.png
convert /tmp/screen.png -paint 3 /tmp/screen.png
#convert /tmp/screen.png -emboss 3 /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
convert /tmp/screen.png  ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png
#mocp -P
i3lock -e -i /tmp/screen.png

