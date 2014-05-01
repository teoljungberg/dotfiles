#!/bin/sh

git_branch() {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
  GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
  [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
}

c() {
  cd ~/code/$1
}
_c() { _files -W ~/code -/; }
compdef _c c

o() {
  cd /opt/$1
}
_o() { _files -W /opt -/; }
compdef _o o

extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)  tar -jxvf $1        ;;
      *.tar.gz)   tar -zxvf $1        ;;
      *.bz2)      bzip2 -d $1         ;;
      *.gz)       gunzip -d $1        ;;
      *.tar)      tar -xvf $1         ;;
      *.tgz)      tar -zxvf $1        ;;
      *.zip)      unzip $1            ;;
      *.Z)        uncompress $1       ;;
      *.rar)      unrar x $1            ;;
      *)          echo "'$1' Error. Unsupported filetype." ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

b() {
  if [[ -a Gemfile ]]; then
    bundle exec $*
  else
    command $*
  fi
}

gci() {
  git commit -m "$*"
}

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status -sb
  fi
}
compdef g=git
