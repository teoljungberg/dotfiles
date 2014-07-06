#!/bin/sh

function precmd {
  # set the current directory as the title for tmux window and terminal tab
  print -Pn "\e]2;%c\a"
  print -Pn "\033]0;%c\007"
  PROMPT="%c %{$fg[yellow]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
