# script to fix screen and X11 interaction when X is closed and restarted.
source ~/.dbus/session-bus/*
XAUTHORITY=$HOME/.Xauthority ; export XAUTHORITY
env_keep="DISPLAY XAUTHORITY"
