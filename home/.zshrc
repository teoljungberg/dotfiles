# Enviorment
PATH=/usr/local/bin:$PATH:$HOME/.bin:$HOME/bin:/usr/local/sbin

# because vi-mode sucks, sorry vim
bindkey -e

# use vimpager as a pager
export PAGER=vimpager

# completion
autoload -Uz compinit && compinit

# movement
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# colors and prompt
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# load up the configs inside ~/.zsh/*
for config_file ($HOME/.zsh/**/*.zsh) source $config_file
