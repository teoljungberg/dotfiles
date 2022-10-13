LANG="en_US.UTF-8"

PATH="$HOME/.nix-profile/bin:$PATH"
PATH="$PATH:$HOME/.bin"
PATH="$PATH:/run/current-system/sw/bin"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/Applications/kitty.app/Contents/MacOS"
typeset -U PATH
export PATH

export VISUAL="vim"

export FZF_DEFAULT_OPTS=--color=bw
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_source_if_available() { [ -e "$1" ] && source "$1" }

_source_if_available "$HOME/.zshenv.local"
