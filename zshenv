if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh

  RUBIES=(~/.rubies/*)

  source /usr/local/opt/chruby/share/chruby/auto.sh
fi
