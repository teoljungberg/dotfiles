_source_if_available() { [ -e "$1" ] && source "$1" }
_append_to_path_if_available() { [ -e "$1" ] && PATH="$PATH:$1" }
_prepend_to_path_if_available() { [ -e "$1" ] && PATH="$1:$PATH" }

_add_to_path_if_available() { _append_to_path_if_available "$1" }

LANG="en_US.UTF-8"

_prepend_to_path_if_available "$HOME/.bin"
_prepend_to_path_if_available "$HOME/.nix-profile/bin"

_append_to_path_if_available "/usr/local/bin"
_append_to_path_if_available "/usr/sbin"
_append_to_path_if_available "/run/current-system/sw/bin"
_append_to_path_if_available "/Applications/kitty.app/Contents/MacOS"

typeset -U PATH
export PATH

CDPATH="$CDPATH:$HOME/src/git.sr.ht:$HOME/src/github.com"
typeset -U CDPATH
export CDPATH

export VISUAL="vim"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_DEFAULT_OPTS="--color=bw"
export EDITOR="$VISUAL"

_source_if_available "$HOME/.zshenv.local"
