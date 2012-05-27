#!/bin/bash

# source .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# rbebv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

