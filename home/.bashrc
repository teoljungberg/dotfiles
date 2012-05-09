# Term
export TERM=screen-256color
export PATH=/usr/local/bin:$PATH:~/.bin:~/bin:/usr/local/sbin

# bash
. ~/.bash/functions
. ~/.bash/colors
. ~/.bash/theme

# completion
. `brew --prefix`/etc/bash_completion
. ~/.bash/completion/brew
. ~/.bash/completion/git
. ~/.bash/completion/hub

# load aliases at end to not conflict with anything
. ~/.bash/aliases

# parting OS specifics
if [ $platform = 'darwin' ]; then
    . ~/.aliases/osx
    . ~/.bash/completion/brew
elif [ $platform = 'linux' ]; then
    . ~/.aliases/linux
fi

# rbebv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
