if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# aliases
alias cap="be cap"
alias testbot='bundle exec rake testbot:rspec 2>&1 | tee tmp/output.txt | grep "^\(Finished.*\.$\|rspec\|\d\+ examples\)"'

# FASTER
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

