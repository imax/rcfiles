# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE=ls:ll:cd:vim:df
export CDPATH='.:..:~/projects/dou/dou-local/:~/projects'
# confirm exit by CTRL-D
# export IGNOREEOF=1

# my environment variables
export GPGKEY=2836A2E1
export GPG_TTY=`tty`
export EDITOR=vim
export MYSQL_PS1='\d> '
export PAGER=less

PATH=~/bin:"${PATH}"
export PATH=$PATH:/usr/local/mysql/bin:/Users/max/homebrew/bin

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# When changing directory small typos can be ignored by Bash
shopt -s cdspell
# Make Bash append rather than overwrite the history on disk
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    PS1='${debian_chroot:+($debian_chroot)}\u@\h\$ '
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

alias s=less
alias j="jobs -l"
alias df="df -hT -xtmpfs"
alias ei="sudo easy_install"
alias gr="gvim --remote"
alias ack=ack-grep
alias mkae=make
alias mkdir="mkdir -p"
alias svnst="svn status"
alias svnup="svn update"
alias svnci="svn ci"
alias svndiff="svn diff|less"
alias hgdiff="hg diff|less"
alias hgci="hg ci"
alias hgst="hg st"
alias sls="sudo less"

alias acs='aptitude search'
alias acw='aptitude show'
alias agu='sudo aptitude update'
alias agg='sudo aptitude upgrade'
alias agi='sudo aptitude install'
alias agr='sudo aptitude remove'

function nsend () {  obexftp  -b 00:12:D2:2C:3B:FB  -B 11 -p "$1"; }
function lf () { find . -type f -iname "*$1*"; }
function fullpath() { echo `pwd`/$1; }
function realpath() { echo `pwd`/$1; }
function ll () { ls -l "$@"; }
function py () {
  for dir in . ..; do 
    if [ -d $dir/py ]; then 
      source $dir/py/bin/activate; 
      return; 
    fi
  done
  echo "py dir not found"
  which virtualenv >/dev/null && virtualenv py && source py/bin/activate
}
function scanjpeg () { scanimage |convert -resize 1800x1200 pnm:- $1; }

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# disable completion for some commands
complete -r cd
