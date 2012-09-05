if [ -d /usr/local/Cellar ]; then # high priority
  PATH="/usr/local/bin:$PATH"
elif [ -d "$HOME/.bin" ]; then # low priority
  PATH="$PATH:$HOME/.bin"
elif [ -d "$HOME/bin" ]; then # ^^
  PATH="$PATH:$HOME/bin"
fi
