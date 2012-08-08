#!/bin/sh

# General aliases
alias bitch,="sudo"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias py="python"
alias rb="ruby"
alias cl='clear'
alias reload='source ~/.zshrc'
alias t='rubdo'
alias kilall='killall'
alias tm='tmux -u2'

# Quick Editing
alias ev="$EDITOR ~/.vimrc"
alias et="$EDITOR ~/.tmux.conf"
alias ez="$EDITOR ~/.zsh"

# listing
alias ls="ls -GF"
alias l='ls -1'
alias ll='ls -l'
alias la='ls -A'
alias lal="ls -Al"
alias lart='ls -1Art'
alias l1='tree --dirsfirst -ChFL 1'
alias l2='tree --dirsfirst -ChFL 2'
alias l3='tree --dirsfirst -ChFL 3'
alias l4='tree --dirsfirst -ChFL 4'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# zmv ftw
autoload -U zmv

# alias for zmv for no quotes
# mmv *.c.orig orig/*.c
alias mmv='noglob zmv -W'

# uniq + sort = uniqsort
alias uniqsort="sort $* | uniq -u | sort"
