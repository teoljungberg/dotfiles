#!/bin/bash
source ~/.bash/locale
source ~/.bash/colors # Load color aliases
source ~/.bash/functions # Load functions
source ~/.bash/shell # Shell behavior
source ~/.bash/path # Add the right things to the path

source ~/.bash/completions # Load various completions
source ~/.bash/completion/git # Git completion
source ~/.bash/completion/hub # Hub completion

source ~/.bash/prompt # Load PS1
source ~/.bash/aliases # Load aliases at end to not conflict with anything

source ~/.bash/rbenv # Load rbenv
source ~/.bash/ruby # Load ruby

source `brew --prefix`/etc/profile.d/z.sh # jumping around
source ~/.bash/tmux # Load tmux
