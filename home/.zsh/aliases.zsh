#!/bin/sh

# General aliases
alias reload='source ~/.zshrc'

# listing
alias ls="ls -GF"
alias l='ls -1'
alias ..='cd ..'
alias ...='cd ../..'

# ruby
alias s='spring'
alias sc='spring rails console'

# Git aliases
alias ga='git aa'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gl="git log --oneline -15"
alias gg="git grep"
