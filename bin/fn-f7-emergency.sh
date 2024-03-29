#!/bin/bash
 
#For identifying our monitors use xrandr tool and view output
#LVDS="LVDS1"      # could be another one like: LVDS, LVDS-1, etc
LVDS="eDP"      # could be another one like: LVDS, LVDS-1, etc
xrandr >  ~/.local/xrandr
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
         xrandr --output $DISP --auto --reflect normal --rotate normal

      ;;
      *)
         xrandr --output $DISP --off
      ;;
   esac
done

#	;;
#	*)
#		xrandr --output $LVDS --auto
#	;;
#esac

nohup background_pop &
notify-send -t 1000 "fn-f7" "Emergency setup complete."

exit
eDP connected primary (normal left inverted right x axis y axis)
HDMI-A-0 disconnected (normal left inverted right x axis y axis)
DisplayPort-0 disconnected (normal left inverted right x axis y axis)
DisplayPort-1 disconnected (normal left inverted right x axis y axis)
DisplayPort-2 connected (normal left inverted right x axis y axis)
DisplayPort-3 disconnected (normal left inverted right x axis y axis)
