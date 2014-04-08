#! /bin/bash
cd ~/BOINC
if ps aux | grep boinc | grep -v grep | grep -v start
then
   boinccmd --set_run_mode always
else
   ~/bin/run_client &
   echo "cannot find boinc.  Starting:"
fi
