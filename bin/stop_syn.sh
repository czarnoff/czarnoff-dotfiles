#! /bin/bash

THING="monster"


function syn_kill {
   echo -n "Killing $THING... "
   #sudo killall synergys
   killall $THING && echo "Dead"
   sleep 1
   killall -9 $THING >> /dev/null 2>&1 && echo "Dead"
   exit 0
}
if pgrep synergys
then
    THING="synergys"
    syn_kill
else
   if pgrep synergyc
   then
      THING="synergyc"
      syn_kill
   else
       echo "Cannot find synergy"
   fi
fi
#sudo service synergy stop
