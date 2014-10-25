#!/bin/bash

# Notify immediatly on bg job completion
set -o notify

# vi mode
set -o vi

# Case insensitive autocompletion
shopt -s nocaseglob

# Vim as default editor
export EDITOR=vim

# To make Vim behave under xterm.
stty -ixon

# Solarized-like colors for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD

# Colorize matched pattern for grep
export GREP_OPTIONS="--color"

# Saner `ctrl-w` behaviour
stty werase undef # undefine previous behaviour
bind '\C-w:unix-filename-rubout'
