#!/bin/bash

# Start from scratch
PS1=''

# Put in current directory only
PS1+='\W'

# If we have __git_ps1 installed, then put it in the prompt. We do what we can
# from the previous two lines.
if command -v __git_ps1 > /dev/null 2>&1; then
  PS1+='\[$YELLOW\]$(__git_ps1 " %s")'
fi

# Normalize prompt contents
PS1+='\[${NORMAL}\] $ '
