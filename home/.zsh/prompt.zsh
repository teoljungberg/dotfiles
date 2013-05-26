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

function precmd {
  rename_tmux_window_to_current_dir
  PROMPT="%c %{$fg[cyan]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
