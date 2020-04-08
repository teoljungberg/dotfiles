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

export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export EDITOR="vim"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export GREP_OPTIONS="--color"
export HOMEBREW_AUTO_UPDATE_SECS=600000
export HOMEBREW_NO_COLOR=1
export HOMEBREW_NO_EMOJI=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export LESS="-F -X -R"
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export VISUAL="$EDITOR"

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

alias b="bundle exec"
alias j="jobs"
alias ls="ls -F"
alias ..="cd .."

# Completion for `bin/git-changed-files`
_git_changed_files() {
  zle -U "$(git changed-files | fzf)"
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
  if [ -n "$TMUX" ] && [ -z "$VIM_TERMINAL" ]; then
    if [ "$PWD" != "$LPWD" ]; then
      LPWD="$PWD"
      tmux rename-window "$(print -Pn "%c")"
    fi
  fi
}

refresh_tmux_environment_variables() {
  if [ -n "$TMUX" ]; then
    export $(tmux show-environment | grep "^THEME") > /dev/null
  fi
}

git_branch() {
  GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
}

projects() {
  result=$(echo "$PROJECTS" | tr ":" "\\n" | sed "/^$/d" | fzf -q "$1")

  cd "$result" || exit
}

p() {
  projects "$@"
}

theme() {
  usage="theme <light|dark>"
  new_style=""

  case "$1" in
    dark)
      new_style="dark"
      ;;
    light)
      new_style="light"
      ;;
    --help|-h)
      echo "$usage"
      return 0
      ;;
    *)
      echo "$usage" >&2
      return 1
  esac

  if [ -n "$new_style" ]; then
    ln -sf \
      "$HOME/.config/kitty/${new_style}.conf" \
      "$HOME/.config/kitty/theme.conf"
    export THEME="$new_style"
  fi

  if command -v kitty >/dev/null; then
    if [ -n "$TMUX" ]; then
      kitty @ --to "$KITTY_LISTEN_ON" \
        set-colors --all --configured "$HOME/.config/kitty/theme.conf"
      tmux set-environment THEME "$THEME"
      tmux source-file "$HOME/.tmux.conf"
    else
      kitty @ \
        set-colors --all --configured "$HOME/.config/kitty/theme.conf"
    fi
  fi

  if [ $(uname -s) = "Darwin" ]; then
    if [ "$new_style" = "dark" ]; then
      should_enable_darkmode="true"
    else
      should_enable_darkmode="false"
    fi

    osascript -e "tell application \"System Events\" \
      to tell appearance preferences to set dark mode to \
      $should_enable_darkmode"
  fi
}

if [ -z "$THEME" ] && [ $(uname -s) = "Darwin" ]; then
  style=$(defaults read -g AppleInterfaceStyle 2> /dev/null)

  if [ "$style" = "Dark" ]; then
    export THEME=dark
  else
    export THEME=light
  fi
fi

[ -f /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh

PATH=".git/safe/../../bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

bindkey '^X^G' _git_changed_files

git_branch_color() {
  if [ "$THEME" = "light" ]; then
    echo "%{$fg_bold[black]%}"
  elif [ "$THEME" = "dark" ]; then
    echo "%{$fg_bold[white]%}"
  else
    echo "%{$fg_bold[black]%}"
  fi
}

preexec() {
  refresh_tmux_environment_variables
}

precmd() {
  rename_tmux_window_to_current_dir
  rename_tab_to_current_dir

  if [ -z $SSH_CONNECTION ]; then
    PROMPT="%c $(git_branch_color)$(git_branch)%{$reset_color%}%# "
  else
    PROMPT="%c@%m $(git_branch_color)$(git_branch)%{$reset_color%}%# "
  fi
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
