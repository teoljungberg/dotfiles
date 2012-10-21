#!/bin/sh

case "$TERM" in
  screen-*)
    alias nssh=/usr/bin/ssh "$@"
    alias ssh="tmux_ssh"
    ;;
esac

alias tcopy='tmux save-buffer -| pbcopy'
