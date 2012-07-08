#!/bin/sh

autoload -Uz vcs_info
zstyle ':vcs_info:*:prompt:*' formats "$VCSPROMPT" "[%b]"

precmd() {
  vcs_info 'prompt'

  if [ -n vcs_info_msg_0_ ]; then
    RPROMPT="${vcs_info_msg_1_}"
  else
    RPROMPT=""
  fi
}

PROMPT="%{$fg[magenta]%}[%{$fg[cyan]%} %~ %{$fg[magenta]%}]%{$reset_color%} %# "

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD

