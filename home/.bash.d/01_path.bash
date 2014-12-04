#!/bin/bash

# homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

if [ -d /Applications/Postgres.app ]; then
  export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin
fi

if [[ -d $HOME/bin ]]; then
  export PATH=$PATH:$HOME/bin
fi
