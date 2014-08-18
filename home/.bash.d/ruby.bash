if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$HOME/.gem"
export PATH="$HOME/.gem/bin:$PATH"

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
