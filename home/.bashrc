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

# theme
. ~/.bash/theme

# opens up an ssh connection in a new tmux window if inside tmux 
case "$TERM" in
  screen-*)
    alias nssh=/usr/bin/ssh "$@"
    alias ssh="tmux_ssh"
    ;;
esac

# load aliases at end to not conflict with anything
. ~/.bash/aliases

# parting OS specifics
if [ $platform = 'darwin' ]; then
  . ~/.bash/osx
  . ~/.bash/completion/brew
elif [ $platform = 'linux' ]; then
  . ~/.bash/linux
fi

# rbebv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

