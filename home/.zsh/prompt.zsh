#!/bin/sh

function precmd {
  print -Pn "\e]2;%c\a" # tmux window
  print -Pn "\033]0;%c\007" # iterm tab
  PROMPT="%c %{$fg[cyan]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
