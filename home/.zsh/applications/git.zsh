#!/bin/sh

# aliases
alias ga='git add'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'
alias gl="git lg `$git_branch | sed -e 's/(//' -e 's/)//'` -n15"
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
alias gco='git checkout'
compdef _git gco=git-checkout
alias go='git checkout'
compdef _git go=git-checkout

function gci {
  git commit -m "$*"
}
