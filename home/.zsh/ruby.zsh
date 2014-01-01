if [ -r /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  RUBIES=(~/.rubies/*)

  chruby 2.0.0
fi

# aliases
alias s='spring'
alias sc='spring rails console'

# FASTER
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

# share gems installed to ~/.gem/shared between rubies
# to install a shared gem:
#       $ gem install bundler -i ~/.gem/shared
if [ -d ~/.gem/shared ]; then
  export GEM_PATH="$HOME/.gem/shared:$GEM_PATH"
fi
