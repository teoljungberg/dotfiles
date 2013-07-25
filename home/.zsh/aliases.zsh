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
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# small application aliases
alias pbp="pbpaste"
alias pbc="pbcopy"

# Typos
alias kilall="killall"
compdef kilall=killall
alias brwe="brew"
compdef brwe=brew

# Git aliases
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'
alias gl="git l -15"
alias gs='git status -sb'
alias gb="git branch"

# with completion
alias g='git'
compdef g=git
alias gd='git diff'
compdef _git gd=git-diff
alias gdc='git diff --cached'
compdef _git gd=git-diff
alias gp='git push'
compdef _git gp=git-push
alias go='git checkout'
compdef _git go=git-checkout
