rename_tmux_window_to_current_dir() {
  if [ ! -z "$TMUX" ]; then
    if [ "$PWD" != "$LPWD" ]; then
      LPWD="$PWD"
      tmux rename-window "$(print -Pn "%c")"
    fi
  fi
}

function precmd {
  rename_tmux_window_to_current_dir
  PROMPT="%c %{$fg[yellow]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
