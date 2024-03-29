#!/bin/bash

fn-f7-switch.sh l L

#sleep 2
#
##TODO: allow for options to change the setup from the below listed default.
#
##For identifying our monitors use xrandr tool and view output
##LVDS="LVDS1"      # ciould be another one like: LVDS, LVDS-1, etc
#LVDS="eDP1"      # ciould be another one like: LVDS, LVDS-1, etc
#HDMI2="DP2-1"
#HDMI3="DP2-2"
#VGA="VGA1"
#EXTRA_L="--left-of $VGA" # addtional info while dual display
#EXTRA_V="--left-of $LVDS" # addtional info while dual display
#EXTRA_VR="--right-of $LVDS" # addtional info while dual display
#EXTRA_VL="--left-of $HDMI2" # addtional info while dual display
#EXTRA_R="--right-of $HDMI3" # addtional info while dual display
#EXTRA_A="--above $LVDS" # addtional info while dual display
#
#CONNECTED_DISPLAYS=$(xrandr | grep " connected " | awk '{print $1}')
#DISCONNECTED_DISPLAYS=$(xrandr | grep " disconnected " | awk '{print $1}')
#NO_DISP=$(echo $CONNECTED_DISPLAYS | wc -w)
#
#
#
#case "$1" in
#    "r" | "R")
#        TURN="--rotate right"
#    ;;
#    "n" | "N")
#        TURN="--rotate normal"
#    ;;
#    "h" | "H" | "help" | "--help")
#        echo "$0 <r|n|l|i>"
#        echo "    r rotate right"
#        echo "    n rotate normal"
#        echo "    l rotate left"
#        echo "    i rotate inverted"
#    ;;
#    "i" | "i")
#        TURN="--rotate inverted"
#        ;;
#    "l" | "L" | *)
#        TURN="--rotate left"
#        ;;
#esac
#
##echo "Connected $CONNECTED_DISPLAYS these are $NO_DISP Displays."
#
#
#for DISP in $DISCONNECTED_DISPLAYS
#do
#	 xrandr --output $DISP --off
#     sleep 0.5
#done
#
#case $NO_DISP in
#   3)
#      for DISP in $CONNECTED_DISPLAYS; do
#         case $DISP in
#            "$VGA")
#               xrandr --output $DISP --auto $EXTRA_VR $TURN
#            ;;
#            $LVDS)
#               xrandr --output $DISP --auto 
#               #echo "xrandr --output $DISP --off"
#            ;;
#            $HDMI3)
#               xrandr --output $DISP --auto $EXTRA_V $TURN
#               #echo "xrandr --output $DISP --auto"
#            ;;
#            $HDMI2)
#               xrandr --output $DISP --auto $EXTRA_VR $TURN
#               #echo "xrandr --output $DISP --auto $EXTRA_R"
#            ;;
#            *)
#               xrandr --output $DISP --auto $EXTRA_V  $TURN
#            ;;
#         esac
#         sleep 0.5
#      done
#      #for DISP in $CONNECTED_DISPLAYS; do
#      #   case $DISP in
#      #      $HDMI2)
#      #         xrandr --output $DISP --pos 900x540
#      #         #echo "xrandr --output $DISP --auto $EXTRA_R"
#      #      ;;
#      #      *)
#      #         #echo "xrandr --output $DISP --auto $EXTRA_R"
#      #      ;;
#      #   esac
#      #done
#
#   ;;
#   2)
#      for DISP in $CONNECTED_DISPLAYS; do
#         case $DISP in
#            "$LVDS")
#               xrandr --output $DISP --auto
#            ;;
#            "$VGA")
#               xrandr --output $DISP --auto $EXTRA_V $TURN
#            ;;
#            *)
#               xrandr --output $DISP --auto $EXTRA_V  $TURN
#            ;;
#         esac
#         sleep 0.5
#      done
#   ;;
#   *)
#      xrandr --output $LVDS --auto
#   ;;
#esac
#
#cd ~
#nohup background_pop &
#notify-send "fn-f7" "Work setup complete."
#
#sleep 1
