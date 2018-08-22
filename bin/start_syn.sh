#! /bin/bash

HOST="gallium-zeppelin"
if pgrep synergys || pgrep synergyc
then
    echo "Synergy running.  Stop first."
else
    echo "Starting synergy"

    case $1 in
        "Client"| "c" | "-c")
            if [ -n "$2" ]
            then 
                HOST=$2
            fi
            echo "Client of $HOST"
            synergyc $HOST
        ;;

         *)
             echo "Starting Server"
             XAUTHORITY=$HOME/.Xauthority ; export XAUTHORITY
             env_keep="DISPLAY XAUTHORITY"
             synergys -c ~/.quicksynergy/synergy.conf
             #synergys
             ;;
     esac
 fi

#sudo service synergy start
