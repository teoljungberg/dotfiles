setopt globdots
setopt nobeep
setopt no_bg_nice # don't nice background tasks
setopt alwaystoend # when complete from middle, move cursor

bindkey "^[[A" history-search-backward
setopt append_history # adds history
setopt extended_history # add timestamps to history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups # don't record dupes in history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR='vim'
export VISUAL="$EDITOR"
export HOMEBREW_EDITOR="$EDITOR"
export PAGER="vimpager"
export LESS="-F -X -R"
export GIT_PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line
bindkey '^X^e' edit-command-line

# Z
source `brew --prefix`/etc/profile.d/z.sh

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' completer _complete _ignored

# completion menu
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
