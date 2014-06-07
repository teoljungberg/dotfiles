#!/bin/sh

# General aliases
alias reload='source ~/.zshrc'

# listing
alias ls="ls -GF"
alias l='ls -1'
alias ll='ls -l'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# Typos
alias kilall="killall"
compdef kilall=killall
alias brwe="brew"
compdef brwe=brew

# Git aliases
alias ga='git aa'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gl="git l -15"
alias gb="git branch"
alias gg="git grep"

# with completion
alias gd='git diff'
compdef _git gd=git-diff
alias gdc='git diff --cached'
compdef _git gd=git-diff
alias gp='git push'
compdef _git gp=git-push
alias go='git checkout'
compdef _git go=git-checkout
