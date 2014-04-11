#!/bin/bash

#For identifying our monitors use xrandr tool and view output
LVDS="LVDS1"      # ciould be another one like: LVDS, LVDS-1, etc
HDMI2="HDMI2"
HDMI3="HDMI3"
EXTRA_L="--left-of $HDMI2" # addtional info while dual display
EXTRA_R="--right-of $HDMI3" # addtional info while dual display

CONNECTED_DISPLAYS=$(xrandr | grep " connected " | awk '{print $1}')
DISCONNECTED_DISPLAYS=$(xrandr | grep " disconnected " | awk '{print $1}')
NO_DISP=$(echo $CONNECTED_DISPLAYS | wc -w)

#echo "Connected $CONNECTED_DISPLAYS these are $NO_DISP Displays."


for DISP in $DISCONNECTED_DISPLAYS
do
	 xrandr --output $DISP --off
done

case $NO_DISP in
   3)
      for DISP in $CONNECTED_DISPLAYS; do
         case $DISP in
            $LVDS)
               xrandr --output $DISP --off
               #echo "xrandr --output $DISP --off"
            ;;
            $HDMI3)
               xrandr --output $DISP --auto --rotate left $EXTRA_L
               #echo "xrandr --output $DISP --auto"
            ;;
            $HDMI2)
               xrandr --output $DISP --auto
               #echo "xrandr --output $DISP --auto $EXTRA_R"
            ;;
            *)
               xrandr --output $DISP --auto
               #echo "xrandr --output $DISP --auto $EXTRA_R"
            ;;
         esac
      done
      for DISP in $CONNECTED_DISPLAYS; do
         case $DISP in
            $HDMI2)
               xrandr --output $DISP --pos 900x540
               #echo "xrandr --output $DISP --auto $EXTRA_R"
            ;;
            *)
               #echo "xrandr --output $DISP --auto $EXTRA_R"
            ;;
         esac
      done

   ;;
   2)
      for DISP in $CONNECTED_DISPLAYS; do
         case $DISP in
            "$LVDS")
               xrandr --output $DISP --auto
            ;;
            *)
               xrandr --output $DISP --auto $EXTRA_L
            ;;
         esac
      done
   ;;
   *)
      xrandr --output $LVDS --auto
   ;;
esac

