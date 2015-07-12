# chruby
if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh

  RUBIES=(~/.rubies/*)

  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

# homebrew
if [ -d /usr/local/bin ]; then
  export PATH=/usr/local/bin:$PATH
  export PATH=$PATH:/usr/local/sbin
fi

export PATH="$PATH:/usr/local/lib/node_modules"
export PATH=".git/safe/../../bin:$PATH"

if [[ -d $HOME/bin ]]; then
  export PATH=$PATH:$HOME/bin
fi

if [ -f ~/.zshenv.local ]; then
  . ~/.zshenv.local
fi
