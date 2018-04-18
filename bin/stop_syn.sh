#! /bin/bash
if pgrep synergys
then
   #sudo killall synergys
   killall synergys
else
   echo "cannot find synergy"
fi
#sudo service synergy stop
