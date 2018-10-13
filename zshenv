[ -r /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh

PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:/usr/local/sbin"

if command -v rustc >/dev/null 2>&1; then
  RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
