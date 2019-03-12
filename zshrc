autoload -U compinit && compinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook

setopt globdots
setopt nobeep
setopt no_bg_nice
setopt alwaystoend
setopt hist_ignore_all_dups inc_append_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export CLICOLOR=1
export EDITOR="vim"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export GREP_OPTIONS="--color"
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_AUTO_UPDATE_SECS=600000
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-F -X -R"
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export VISUAL="$EDITOR"

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

alias b="bundle exec"
alias j="jobs"
alias ..="cd .."

_prepend_to_path_without_duplication() {
  case ":$PATH:" in
    *":$1:"* )
      ;;

    *)
      PATH="$1:$PATH"
      ;;
  esac
}

_add_trusted_local_bin_to_path() {
  if [ -d "$PWD/.git/safe" ]; then
    _prepend_to_path_without_duplication ".git/safe/../../bin"
  else
    _remove_from_path ".git/safe/../../bin"
  fi
}

_remove_from_path() {
  PATH=$(echo "$PATH" | sed -e "s|$1:||")
}

# Completion for `bin/git-changed-files`
_git_changed_files() {
  zle -U "$(git changed-files | pick)"
  zle list-expand
}
zle -N _git_changed_files

# Completion for `bin/git-delete-branch`
_git_delete_branch() {
  __gitcomp "$(__git_heads)"
}

# Completion for `git p`
_git_p() {
  __gitcomp "$(__git_heads)"
}

# Completion for `bin/pick-file`
_pick_file() {
  zle -U "$(pick-file)"
  zle list-expand
}
zle -N _pick_file

# Inside tmux(1) - run builtin clear and clear tmux history.
# Outside tmux(1) - run builtin clear.
clear() {
  original_clear=$(whence -p clear)

  if [ -n "$TMUX" ]; then
    $original_clear && tmux clear-history
  else
    $original_clear
  fi
}

# No arguments: `git status`
# With arguments: acts like `git`
git() {
  original_git=$(whence -p git)

  if [ $# -gt 0 ]; then
    $original_git "$@"
  else
    $original_git status -sb
  fi
}

_has_subdirs() {
  [ -d "$1" ] && [ "$(find "$1" -type d -maxdepth 1 | wc -l)" -gt 1 ]
}

add_subdirs_to_projects() {
  if _has_subdirs "$1"; then
    for subdir in "$1"/*; do
      PROJECTS="$PROJECTS:$subdir"
    done
  fi
}

rename_tab_to_current_dir() {
  print -Pn "\\033]0;%c\\007"
}

rename_tmux_window_to_current_dir() {
  if [ -n "$TMUX" ]; then
    if [ "$PWD" != "$LPWD" ]; then
      LPWD="$PWD"
      tmux rename-window "$(print -Pn "%c")"
    fi
  fi
}

git_branch() {
  GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
}

projects() {
  result=$(echo "$PROJECTS" | tr ":" "\\n" | sed "/^$/d" | pick -q "$1")

  cd "$result" || exit
}

p() {
  projects "$@"
}

ssh() {
  original_ssh=$(whence -p ssh)

  if [ -z "$TMUX" ]; then
    $original_ssh "$@"
    return
  fi

  remote="$1"
  old_name="$(tmux display-message -p "#W")"

  if [ -n "$remote" ]; then
    tmux rename-window "$remote"
  fi

  $original_ssh "$@"

  tmux rename-window "$old_name"
}

add-zsh-hook preexec "_add_trusted_local_bin_to_path"

[ -f /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh
[ -f /usr/local/etc/bash_completion.d/asdf.bash ] &&
  source /usr/local/etc/bash_completion.d/asdf.bash

if command -v kitty >/dev/null; then
  kitty + complete setup zsh | source /dev/stdin
fi

add_subdirs_to_projects "$HOME/src"

# to make vim behave under xterm
stty -ixon

bindkey -v

# command line editing
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^X^e' edit-command-line
bindkey -M viins '^X^e' edit-command-line

bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward

bindkey -M viins "^q" push-line-or-edit

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^X^P' history-beginning-search-backward-end
bindkey '^X^N' history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey -M viins '\e_' insert-last-word

bindkey '^X^F' _pick_file
bindkey '^X^G' _git_changed_files

precmd() {
  rename_tmux_window_to_current_dir
  rename_tab_to_current_dir

  if [ -z $SSH_CONNECTION ]; then
    PROMPT="%c %{$fg[yellow]%}$(git_branch)%{$reset_color%}%# "
  else
    PROMPT="%c@%m %{$fg[yellow]%}$(git_branch)%{$reset_color%}%# "
  fi
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
