#!/bin/bash

# homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

export PATH="$PATH:/usr/local/lib/node_modules"
source $(brew --prefix nvm)/nvm.sh

if [[ -d $HOME/bin ]]; then
  export PATH=$PATH:$HOME/bin
fi
