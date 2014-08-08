if [ -r /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  RUBIES=(~/.rubies/*)

  chruby 2.1.2
fi

# aliases
alias s='spring'
alias sc='spring rails console'
alias zomg='omg `echo ${PWD##*/}`'

# FASTER
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
