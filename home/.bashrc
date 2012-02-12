# Term
export TERM=screen-256color

# the users PATH
export PATH=/usr/local/bin:$PATH:~/.bin:/usr/local/sbin

# load bash' colors
source ~/.bash/colors

# Load PS1 theme including theme for ls
source ~/.bash/theme

# set editor
export EDITOR=vim

# Load git completion
source ~/.bash/completion/git

# Load brew commpletion for osx
if [ -f ~/.osx ]; then
    source ~/.bash/completion/brew
fi

# Load bash completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Load aliases at end to not conflict with anything
source ~/.bash/aliases

# For parting differnt OS specific aliases
if [ -f ~/.osx ]; then
    source ~/.aliases/osx_aliases
elif [ -f ~/.linux ]; then
    source ~/.aliases/linux_aliases
fi

# Load private aliases
if [ -f ~/.aliases/private ]; then
    source ~/.aliases/private
fi
