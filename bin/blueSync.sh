#!/bin/bash

echo  connect FC:58:FA:91:9F:BA | bluetoothctl

sleep 1

BLUEZNUM=`pactl list short cards | grep bluez_card | cut -f1 `
BLUEZCARD=`pactl list short sinks | grep bluez_sink | cut -f2 `

echo $BLUEZCARD
echo $BLUEZNUM
pactl set-card-profile $BLUEZNUM headset_head_unit
sleep 0.5
pactl set-card-profile $BLUEZNUM a2dp_sink
pactl set-default-sink $BLUEZCARD
pactl set-sink-mute $BLUEZCARD 0
sleep 0.5
pactl set-sink-volume $BLUEZCARD 35000
