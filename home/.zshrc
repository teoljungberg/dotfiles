# Enviorment
PATH=/usr/local/bin:$PATH:~/.bin:/usr/local/sbin
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# because vi-mode sucks
bindkey -e

# completion
autoload -U compinit && compinit

# movement
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# colors and prompt
autoload -U colors && colors
autoload -U promptinit && promptinit

# load up the configs inside ~/.zsh/*
for config_file ($HOME/.zsh/**/*.zsh) source $config_file

# rbebv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

