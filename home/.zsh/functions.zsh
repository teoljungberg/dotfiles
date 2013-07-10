#!/bin/sh

git_branch() {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
  GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
  [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
}

rename_tmux_window_to_current_dir() {
  if [ "$TERM" = "screen-256color" ]; then
    if [ "$PWD" != "$LPWD" ]; then
      LPWD="$PWD"
      tmux rename-window ${PWD//*\//}
    fi
  fi
}

tarit () {
  tar cvzf tmp.tgz $@
}

extract () {
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

tmux_ssh () {
  tmux new-window -n $1 "/usr/bin/ssh $*"
}

trash () {
  mv -fv $@ ~/.Trash
}

be() {
  if [[ -a Gemfile ]]; then
    bundle exec $*
  else
    command $*
  fi
}

gci() {
  git commit -m "$*"
}
