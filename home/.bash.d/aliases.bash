# General aliases
alias reload='source ~/.bashrc'

# listing
alias ls="ls -GF"
alias l='ls -1'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status -sb
  fi
}
complete -o default -o nospace -F _git g
alias ga='git aa'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gl="git l -15"
alias gb="git branch"
alias gg="git grep"

# with completion
alias gd='git diff'
complete -o default -o nospace -F _git_diff gd
alias gdc='git diff --cached'
complete -o default -o nospace -F _git_diff gdc
