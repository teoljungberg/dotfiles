# high priority
if [ -d /usr/local/Cellar ]; then
  PATH="/usr/local/bin:$PATH"
fi

export PATH="$PATH:/sbin"

# ^^
if [ -d "$HOME/bin" ]; then
  PATH="$PATH:$HOME/bin"
fi
