#!/bin/sh

function precmd {
  rename_tmux_window_to_current_dir
  PROMPT="%c %{$fg[cyan]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
