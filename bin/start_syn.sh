#! /bin/bash
if pgrep synergys
then
    echo "Synergy running.  Stop first."
else
    echo "Starting synergy"
    XAUTHORITY=$HOME/.Xauthority ; export XAUTHORITY
    env_keep="DISPLAY XAUTHORITY"
    synergys -c ~/.quicksynergy/synergy.conf
    #synergys
fi

#sudo service synergy start
