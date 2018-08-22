#! /bin/bash
if pgrep synergys
then
   echo "Killing server"
   #sudo killall synergys
   killall synergys
   sleep 1
   killall -9 synergys
else
   if pgrep synergyc
   then
       echo "Killing client"
       killall synergyc
       sleep 1
       killall -9 synergyc
       exit 0
   else
       echo "Cannot find synergy"
   fi
fi
#sudo service synergy stop
