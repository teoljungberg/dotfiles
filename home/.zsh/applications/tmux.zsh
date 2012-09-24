#!/bin/sh

case "$TERM" in
  screen-*)
    alias nssh=/usr/bin/ssh "$@"
    alias ssh="tmux_ssh"
    ;;
esac

alias tmux-to-clip='tmux save-buffer -| pbcopy'
alias tmux-from-clip='tmux set-buffer "$(pbpaste)"'
