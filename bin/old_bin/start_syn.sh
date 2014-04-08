#! /bin/bash
if ps aux | grep synergys | grep -v grep 
then
    echo "Synergy running.  Stop first."
else
    echo "Starting synergy"
    XAUTHORITY=$HOME/.Xauthority ; export XAUTHORITY
    env_keep="DISPLAY XAUTHORITY"
    sudo synergys
    #synergys
fi
