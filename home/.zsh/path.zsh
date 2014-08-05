# high priority
if [ -d /usr/local/Cellar ]; then
  PATH="/usr/local/bin:$PATH"
fi

PATH="$PATH:/sbin"
PATH="$PATH:/usr/sbin"

# ^^
if [ -d "$HOME/bin" ]; then
  PATH="$PATH:$HOME/bin"
fi

export PATH
