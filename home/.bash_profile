# homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

export PATH="$PATH:/usr/local/lib/node_modules"

export MANPATH="~/.man:$MANPATH"

if [[ -d $HOME/bin ]]; then
  export PATH=$PATH:$HOME/bin
fi

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

. ~/.bashrc
