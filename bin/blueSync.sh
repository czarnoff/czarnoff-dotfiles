#!/bin/bash

BLUEZNUM=`pactl list short cards | grep bluez_card | cut -f1 `
BLUEZCARD=`pactl list short sinks | grep bluez_sink | cut -f2 `

echo $BLUEZCARD
echo $BLUEZNUM
pactl set-card-profile $BLUEZNUM headset_head_unit
sleep 0.5
pactl set-card-profile $BLUEZNUM a2dp_sink
pactl set-default-sink $BLUEZCARD
