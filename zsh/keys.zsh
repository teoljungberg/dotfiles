# to make vim behave under xterm
stty -ixon

bindkey -v

# command line editing
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^X^e' edit-command-line
bindkey -M viins '^X^e' edit-command-line

# emacs keys for vim
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward

bindkey -M viins "^q" push-line-or-edit

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^X^P' history-beginning-search-backward-end
bindkey '^X^N' history-beginning-search-forward-end

# Search history in vim
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey -M viins '\e_' insert-last-word

# `bin/pick-file`
bindkey '^X^F' _pick_file

# `bin/git-changed-files`
bindkey '^X^G' _git_changed_files
