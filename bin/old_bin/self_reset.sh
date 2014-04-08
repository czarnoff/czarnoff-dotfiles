#!/bin/bash
if  ping -c 5 `/sbin/route -n | grep eth0 | grep G | cut -b 17-32` 
then
   echo "ok"
else
   echo "Reboot"
fi
