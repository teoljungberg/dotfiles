# high priority
if [ -d /usr/local/Cellar ]; then
  PATH="/usr/local/bin:$PATH"
fi

# low priority
if [ -d "$HOME/.bin" ]; then
  PATH="$PATH:$HOME/.bin"
fi

# ^^
if [ -d "$HOME/bin" ]; then
  PATH="$PATH:$HOME/bin"
fi
