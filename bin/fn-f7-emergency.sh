#!/bin/bash
 
#For identifying our monitors use xrandr tool and view output
LVDS="eDP1"      # ciould be another one like: LVDS, LVDS-1, etc
EXTRA_R="--right-of $LVDS" # addtional info while dual display

CONNECTED_DISPLAYS=$(xrandr | grep " connected " | awk '{print $1}')
DISCONNECTED_DISPLAYS=$(xrandr | grep " disconnected " | awk '{print $1}')
#NO_DISP=$(echo $CONNECTED_DISPLAYS | wc -w)

#echo "Connected $CONNECTED_DISPLAYS these are $NO_DISP Displays."


for DISP in $DISCONNECTED_DISPLAYS
do
	 xrandr --output $DISP --off
done

#case $NO_DISP in
#	3)
#		for DISP in $CONNECTED_DISPLAYS; do
#                        case $DISP in 
#                                $LVDS)
#                                        xrandr --output $DISP --off
#					#echo "xrandr --output $DISP --off"
#                                ;;
#				$VGA)
#					xrandr --output $DISP --auto
#					#echo "xrandr --output $DISP --auto"
#				;;
#                                *)
#                                        xrandr --output $DISP --auto $EXTRA_R
#					#echo "xrandr --output $DISP --auto $EXTRA_R"
#                                ;;
#                        esac
#                done  
#
#	;;
#	2)
for DISP in $CONNECTED_DISPLAYS; do
    case $DISP in
      "$LVDS")
         xrandr --output $DISP --auto
      ;;
      *)
         xrandr --output $DISP --off
      ;;
   esac
done

for DISP in $CONNECTED_DISPLAYS; do
    case $DISP in
      "$LVDS")
         xrandr --output $DISP --auto
      ;;
      *)
         xrandr --output $DISP $EXTRA_R
      ;;
   esac
done
#	;;
#	*)
#		xrandr --output $LVDS --auto
#	;;
#esac

