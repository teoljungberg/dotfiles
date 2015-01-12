#!/bin/bash

# homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

if [[ -d $HOME/bin ]]; then
  export PATH=$PATH:$HOME/bin
fi
