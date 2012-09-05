# because vi-mode sucks, sorry vim
bindkey -e

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
