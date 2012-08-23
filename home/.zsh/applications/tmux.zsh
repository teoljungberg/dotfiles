#!/bin/sh

case "$TERM" in
  screen-*)
    alias nssh=/usr/bin/ssh "$@"
    alias ssh="tmux_ssh"
    ;;
esac

alias tmux_to_clip='tmux save-buffer -| pbcopy'
alias tmux_from_clip='tmux set-buffer "$(pbpaste)"'
