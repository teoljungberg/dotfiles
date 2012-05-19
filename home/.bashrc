#!/bin/bash 

. ~/.bash/colors
. ~/.bash/functions

# completion
. /etc/bash_completion

# path
export PATH=/usr/local/bin:$PATH:~/.bin:~/bin:/usr/local/sbin

# completion
. ~/.bash/completion/git
. ~/.bash/completion/hub
. ~/.bash/completion/brew

# term
#export TERM=screen-256color

# theme
. ~/.bash/theme

# load aliases at end to not conflict with anything
. ~/.bash/aliases

# parting OS specifics
if [ $platform = 'darwin' ]; then
  . ~/.bash/osx
elif [ $platform = 'linux' ]; then
  . ~/.bash/linux
fi

# rbebv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
