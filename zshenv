LANG="en_US.UTF-8"

typeset -U PATH
if [ -z "$TMUX" ]; then
  PATH="$PATH:$HOME/.bin"
  PATH="$PATH:$HOME/.cargo/bin"
  PATH="$PATH:/usr/local/sbin"
  PATH="$PATH:/run/current-system/sw/bin:$PATH"
fi
export PATH

if command -v rustc >/dev/null 2>&1; then
  RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

export FZF_DEFAULT_OPTS=--color=bw
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
