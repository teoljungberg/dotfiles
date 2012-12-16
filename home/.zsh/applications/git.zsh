#!/bin/sh

# aliases
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'

# with completion
alias g='git'
compdef g=git
alias gs='git status -sb'
compdef _git gst=git-status
alias gd='git diff'
compdef _git gd=git-diff
alias gp='git push'
compdef _git gp=git-push
alias gco='git checkout'
compdef _git gco=git-checkout
alias go='git checkout'
compdef _git go=git-checkout
alias gb='git branch'
compdef _git gb=git-branch
