LANG="en_US.UTF-8"

typeset -U PATH
if [ -z "$TMUX" ]; then
  PATH="$PATH:$HOME/.bin"
  PATH="$PATH:/run/current-system/sw/bin:$PATH"
  PATH="$PATH:/usr/sbin"
  PATH="$PATH:/usr/local/bin"
fi
export PATH

export VISUAL="vim"

export FZF_DEFAULT_OPTS=--color=bw
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_source_if_available() { [ -e "$1" ] && source "$1" }

_source_if_available "$HOME/.zshenv.local"
