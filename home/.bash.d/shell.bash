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

# Plenty big history for searching backwards and doing analysis
export HISTFILESIZE=100000
