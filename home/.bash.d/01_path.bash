#!/bin/bash

# homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

if [ -d /Applications/Postgres93.app ]; then
  export PATH=$PATH:/Applications/Postgres93.app/Contents/MacOS/bin
fi

if [[ -d $HOME/bin ]]; then
  export PATH=$PATH:$HOME/bin
fi
