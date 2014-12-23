. ~/.bashrc

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi
