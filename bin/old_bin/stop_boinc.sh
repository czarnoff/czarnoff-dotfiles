#! /bin/bash
if [ -z $1 ]
then
   X=3600
else
   X=$1
fi
echo -n $X
if ps aux | grep boinc | grep -v grep | grep -v stop
then
   cd ~/BOINC
   boinccmd --set_run_mode never $X
else
   echo "cannot find boinc"
fi
