#!/bin/bash

BLUEZNUM=`pactl list cards | grep -C 1 bluez_card | grep Card | sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/'`
BLUEZCARD=`pactl list sinks | grep bluez_sink | grep Name | cut -d':' -f2-`

echo $BLUEZCARD
echo $BLUEZNUM
pactl set-card-profile $BLUEZNUM headset_head_unit
sleep 0.5
pactl set-card-profile $BLUEZNUM a2dp_sink
pactl set-default-sink $BLUEZCARD
