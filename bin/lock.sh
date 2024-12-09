#!/bin/bash
st -t "Lock" -e bin/praise 1&
notify-send -t 500 "Lock" "Stopping Audio."
mute_all m
mic_mute m
volume
mpc stop
sleep 1

killall screenkey >> /dev/null 2>&1

function locker {
  i3lock -e -i /tmp/screen.png
  until (! pkill -0 i3lock)
  do
    sleep 1
  done
  pkill fprintd-verify
}


if [ -n "$1" ]
then
    fn-f7-emergency.sh

    if [ "$1" == "h" ]
    then
      notify-send -t 500 "Lock" "hibernating"
    else
      notify-send -t 500 "Lock" "Suspending"
    fi
    stop_syn.sh
    sleep 0.5 
    echo 'restart()' | qtile shell
    nmcli radio wifi on
    notify-send -t 500 "Lock" "Enabling wifi"
    sleep 2
    if [ "$1" == "h" ]
    then
      systemctl hibernate
    else
      systemctl suspend
    fi
    asdf
fi

rm /tmp/screen.png
scrot /tmp/screen.png

notify-send -t 500 "Lock" "Locking screen."

#magick /tmp/screen.png -paint 3 -modulate 80 /tmp/screen.png
magick /tmp/screen.png -paint 3 /tmp/screen.png
#magick /tmp/screen.png -emboss 3 /tmp/screen.png
magick /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
magick /tmp/screen.png  ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png
#mocp -P

locker &

## log error until $pid is gone, or fingerprint is verified 
until (! pkill -0 i3lock) || fprintd-verify -f any; do
  notify-send -t 5 "Lock" "Finger print not accepted."
  sleep 0.5
done
pkill i3lock

