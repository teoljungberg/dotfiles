#!/bin/sh

# General aliases
alias bitch,="sudo"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias py="python"
alias rb="ruby"
alias kilall='killall'
alias reload='source ~/.zshrc'
alias t='todo'

# ls
alias ls="ls -GF"
alias l='ls -1'
alias ll='ls -l'
alias la='ls -A'
alias lal="ls -Al"
alias cl='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# use vimpager as a pager
export PAGER=vimpager

# zmv ftw
autoload -U zmv

# alias for zmv for no quotes
# mmv *.c.orig orig/*.c
alias mmv='noglob zmv -W'

# uniq + sort = uniqsort
alias uniqsort="sort $* | uniq -u | sort"
