# alias
# chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby 1.9.3
export RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline) $RUBY_CONFIGURE_OPTS" # build rubies with readline

alias be="bundle exec"
alias testbot='bundle exec rake testbot:rspec 2>&1 | tee tmp/output.txt | grep "^\(Finished.*\.$\|rspec\|\d\+ examples\)"'

# FASTER
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000
