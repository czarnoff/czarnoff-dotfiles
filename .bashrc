# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
   PATH="${HOME}/bin:${PATH}"
fi

# If not running interactively, don't do anything
case $- in
   *i*) ;;
*) return;;
esac
echo "Loading bashrc"
echo "Setup history"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

echo "setup less"
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#   debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#   xterm-color) color_prompt=yes;;
#esac

#echo "setup color prompt"
## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
#force_color_prompt=yes
#
#if [ -n "$force_color_prompt" ]; then
#   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#      # We have color support; assume it's compliant with Ecma-48
#      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#      # a case would tend to support setf rather than setaf.)
#      color_prompt=yes
#   else
#      color_prompt=
#   fi
#fi
#
#if [ "$color_prompt" = yes ]; then
#   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt
#
#echo -e "$PS1"
#echo "More term mucking"
## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#   xterm*|rxvt*)
#      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#      ;;
#   *)
#      ;;
#esac
#echo -e "$PS1"
#
echo "setup dircolors"
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   alias ls='ls --color=auto'
   #alias dir='dir --color=auto'
   #alias vdir='vdir --color=auto'

   alias grep='grep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
fi

echo "setup aliases"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

echo "More aliases"
if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

#echo "setup bash completion"
## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
#if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#      . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#      . /etc/bash_completion
#   fi
#fi
echo "Pick Term colors"
#Do everything in this step in base 16 (24= 6*6)
USER_HOSTNAME=`echo "ibase=16; ( $(hostname | md5sum | sed 's/\(.*\)/\U\1/g' ) 0 ) % 24" | bc`


echo "even more term mucking"
# Change the window title of X terminals
case $TERM in
	screen|screen-256color|xterm*|rxvt|Eterm|eterm|st-256color)
    #PS1='\[\033]0;\u@\h:\!: \w\007\]\[\033[0;33m\]\t\w\n\[\033[00;34m\]\u\[\033[00;31m\]@\h:\$ \[\033[00m\]'
    U_H1=`echo "$USER_HOSTNAME % 6 + 1"|bc`
    U_H2=`echo "$USER_HOSTNAME / 6 + 1"|bc`
    echo $U_H1:$U_H2
    PS1="\[\033[0;33m\]\t:[\[\033[0;37m\]\!\[\033[0;33m\]]:\w\n\[\033[00;3${U_H1}m\]\u\[\033[00;3${U_H2}m\]@\h:\$ \[\033[00m\]"
    unset U_H1 U_H2 USER_HOSTNAME
    export BROWSER="/usr/bin/google-chrome"

      ;;
esac
echo -e "$PS1"

echo "setup path"
alias cd_sw='cd `pwd | cut -d/ -f -5`'
if [ -e "/cygdrive" ]
then
   #export JAVA_HOME='/cygdrive/c/Program Files/Java/jdk1.8.0_25'
   export ANDROID_HOME='/cygdrive/c/Program Files (x86)/Android/android-sdk'
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   export PATH=$JAVA_HOME/bin:$PATH
else
   if [ -e /usr/share/source-highlight/src-hilite-lesspipe.sh ]
   then
      export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
      export LESS=' -R '
   fi
fi

## Set PATH so it includes user's private game if it exists
#if [ -d "${HOME}/games" ] ; then
#   PATH="${HOME}/games:${PATH}"
#fi

if [ -x /usr/bin/ipython3 ];then
   alias ipython=/usr/bin/ipython3
fi

alias vps='ssh -X jeffery@jawmark.net'
alias vps2='ssh -X jeffery@192.210.139.192'

#echo "xsh"
#source ~/.xsh

echo "gvm"
#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
