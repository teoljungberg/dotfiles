rename_tmux_window_to_current_dir() {
  if [ ! -z "$TMUX" ]; then
    if [ "$PWD" != "$LPWD" ]; then
      LPWD="$PWD"
      tmux rename-window $(print -Pn "%c")
    fi
  fi
}

function precmd {
  # set the current directory as the title for tmux window and terminal tab
  rename_tmux_window_to_current_dir
  print -Pn "\033]0;%c\007"
  PROMPT="%c %{$fg[yellow]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
