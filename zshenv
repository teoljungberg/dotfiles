_source_if_available() { [ -e "$1" ] && source "$1" }
_add_to_path_if_available() { [ -e "$1" ] && PATH="$1:$PATH" }

LANG="en_US.UTF-8"

_add_to_path_if_available "/run/current-system/sw/bin"
_add_to_path_if_available "/run/wrappers/bin"
_add_to_path_if_available "/usr/sbin"
_add_to_path_if_available "/usr/local/bin"
_add_to_path_if_available="/Applications/kitty.app/Contents/MacOS"
_add_to_path_if_available "$HOME/.nix-profile/bin"
_add_to_path_if_available "$HOME/.bin"
typeset -U PATH
export PATH

export VISUAL="vim"

export FZF_DEFAULT_OPTS=--color=bw
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_source_if_available "$HOME/.zshenv.local"
