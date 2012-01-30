# Load colors
source ~/.bash/colors

# Setting up editor 
export EDITOR=vim

# Add user bins to path, prioritize Homebrew's above anything else
export PATH=/usr/local/bin:$PATH:~/.bin:/usr/local/lib/node:/usr/local/sbin:/usr/local/mysql/bin

# Term
export TERM=screen-256color

# Load PS1 theme includeing theme for ls
source ~/.bash/theme

# For parting differnt OS specific aliases
if [ -f ~/.osx ]; then
    source ~/.aliases/osx_aliases
fi

if [ -f ~/.linux ]; then
    source ~/.aliases/linux_aliases
fi

# Load git completion
source ~/.bash/completion/git

# Load brew commpletion
if [ -f ~/.osx ]; then
    source ~/.bash/completion/brew
fi

# Load bash completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Load private scripts n' stuff
if [ -f ~/.aliases/private ]; then
    source ~/.aliases/private
fi

# Load aliases at end to not conflict with anything
source ~/.bash/aliases
