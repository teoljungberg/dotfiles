# high priority
if [ -d /usr/local/Cellar ]; then
  PATH="/usr/local/bin:$PATH"
fi

# ^^
if [ -d "$HOME/bin" ]; then
  PATH="$PATH:$HOME/bin"
fi
