#!/bin/bash

INPUT=$(xinput | grep -i "synps" )
echo $INPUT


if [ -n "$INPUT" ]
then
   for x in $INPUT
   do
      case $x in
         id*)
            xinput set-prop $(echo $x | cut -d= -f2) "Device Enabled" 0
            ;;
         *)
            ;;
      esac
   done
fi
