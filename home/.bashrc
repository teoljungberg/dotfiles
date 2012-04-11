# Term
export TERM=screen-256color

# the users PATH
export PATH=/usr/local/bin:$PATH:~/.bin:~/bin:/usr/local/sbin

# functions
source ~/.bash/functions

# load bash' colors
source ~/.bash/colors

# Load PS1 theme including theme for ls
source ~/.bash/theme

# Load bash completion
source /etc/bash_completion

# Load git completion
source ~/.bash/completion/git

# Load aliases at end to not conflict with anything
source ~/.bash/aliases

# For parting OS specifics
if [ $platform = 'darwin' ]; then
    source ~/.aliases/osx
    source ~/.bash/completion/brew
elif [ $platform = 'linux' ]; then
    source ~/.aliases/linux
fi

# rbebv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
