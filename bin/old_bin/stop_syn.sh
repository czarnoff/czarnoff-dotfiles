#! /bin/bash
if ps aux | grep synergys | grep -v grep 
then
   sudo killall synergys
   #killall synergys
else
   echo "cannot find synergy"
fi
