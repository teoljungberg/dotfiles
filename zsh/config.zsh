setopt globdots
setopt nobeep
setopt no_bg_nice # don't nice background tasks
setopt alwaystoend # when complete from middle, move cursor
setopt autocd

export EDITOR='vim'
export VISUAL="$EDITOR"
export LESS="-F -X -R"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export GREP_OPTIONS="--color"
export HOMEBREW_NO_EMOJI=1
export TERM=xterm-256color-italic

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' completer _complete _ignored
