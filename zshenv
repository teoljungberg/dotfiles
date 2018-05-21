[ -r /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh

PATH="$PATH:$HOME/.bin"
PATH="$PATH:/usr/local/sbin"

[ -r "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"

[ -f ~/.zshenv.local ] && source ~/.zshenv.local
