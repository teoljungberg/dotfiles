[ -r /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh

PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:/usr/local/sbin"

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
