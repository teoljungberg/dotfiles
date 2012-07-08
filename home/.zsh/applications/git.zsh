#!/bin/sh

# Git
alias git=hub
compdef hub=git

alias g='git'
compdef g=git
alias gs='git status -sb'
compdef _git gst=git-status
alias gd='git diff'
compdef _git gd=git-diff
alias gp='git push'
compdef _git gp=git-push
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
alias ga='git add'
compdef _git ga=git-add

