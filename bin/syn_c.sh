#! /bin/bash
if pgrep synergy
then
    pkill synergy
fi
echo "Starting synergy"
XAUTHORITY=$HOME/.Xauthority ; export XAUTHORITY
env_keep="DISPLAY XAUTHORITY"
host=`grep Hostname .quicksynergy/quicksynergy.conf | cut -d '=' -f2`

synergyc $host
#synergys

