#!/bin/bash

INPUT=$(xinput | grep -i -e "synaptics" -e "touchscreen")
echo $INPUT


if [ -n "$INPUT" ]
then
   for x in $INPUT
   do
      case $x in
         id*)
            xinput set-prop $(echo $x | cut -d= -f2) "Device Enabled" 0
            echo "Disabled $x"
            ;;
         *)
            ;;
      esac
   done
fi
