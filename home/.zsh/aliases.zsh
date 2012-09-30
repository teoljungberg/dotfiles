#!/bin/sh

# General aliases
alias bitch,="sudo"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias rb="ruby"
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
alias diff='colordiff -u'
alias pbp="pbpaste"
alias pbc="pbcopy"
alias brewup='brew update --rebase && brew upgrade -v && brew cleanup -v'

# Typos
alias kilall="killall"
compdef kilall=killall
alias brwe="brew"
compdef brwe=brew

