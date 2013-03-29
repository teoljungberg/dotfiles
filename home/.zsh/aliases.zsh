#!/bin/sh

# General aliases
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias grep="grep --color=auto"
alias reload='source ~/.zshrc'

# listing
alias ls="ls -GF"
alias l='ls -1'
alias ll='ls -l'
alias la='ls -A'
alias lal="ls -Al"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# small application aliases
alias t='rubdo'
alias pbp="pbpaste"
alias pbc="pbcopy"

# Typos
alias kilall="killall"
compdef kilall=killall
alias brwe="brew"
compdef brwe=brew
