#!/bin/bash 

. ~/.bash/colors
. ~/.bash/functions

# path
export PATH=/usr/local/bin:$PATH:~/.bin:~/bin:/usr/local/sbin

# bash
. /etc/bash_completion

# completion
. ~/.bash/completion/git
. ~/.bash/completion/hub
. ~/.bash/completion/brew

# term
export TERM=screen-256color

# theme
. ~/.bash/theme

# load aliases at end to not conflict with anything
. ~/.bash/aliases

# parting OS specifics
if [ $platform = 'darwin' ]; then
  . ~/.aliases/osx
elif [ $platform = 'linux' ]; then
  . ~/.aliases/linux
fi
