# command line editing
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^Xe' edit-command-line
bindkey -M viins '^Xe' edit-command-line

# emacs keys for vim
bindkey -M viins '^A' beginning-of-line
bindkey -M vicmd 'H' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M vicmd 'L' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward
