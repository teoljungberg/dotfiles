_source_if_available() { [ -e "$1" ] && source "$1" }
_append_to_path_if_available() { [ -e "$1" ] && PATH="$PATH:$1" }
_prepend_to_path_if_available() { [ -e "$1" ] && PATH="$1:$PATH" }

_add_to_path_if_available() { _append_to_path_if_available "$1" }

LANG="en_US.UTF-8"

_prepend_to_path_if_available "$HOME/.bin"
_prepend_to_path_if_available "$HOME/.fzf/bin"
_prepend_to_path_if_available "$HOME/.nix-profile/bin"

_append_to_path_if_available "/usr/local/bin"
_append_to_path_if_available "/usr/sbin"
_append_to_path_if_available "/run/current-system/sw/bin"
_append_to_path_if_available "/nix/var/nix/profiles/default/bin"
_append_to_path_if_available "/Applications/Ghostty.app/Contents/MacOS"

typeset -U PATH
export PATH

CDPATH="$CDPATH:$HOME/src:$HOME/src/git.sr.ht:$HOME/src/github.com"
typeset -U CDPATH
export CDPATH

if command -v nvim > /dev/null 2>&1; then
  export VISUAL="nvim"
else
  export VISUAL="vim"
fi

export EDITOR="$VISUAL"

export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--color=bw"

_source_if_available "$HOME/.zshenv.local"
