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

export EDITOR="vim"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-F -X -R"
export NIX_PATH="darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$NIX_PATH"
export NIX_PATH="darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH"
export NIX_PATH="home-manager=$HOME/.nix-defexpr/channels/home-manager:$NIX_PATH"
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export RPS1=""
export RUBY_CONFIGURE_OPTS=--"with-readline-dir=$HOME/.nix-profile/include/readline/"
export THOR_SHELL=Basic
export VISUAL="$EDITOR"

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

alias b="bundle exec"
alias j="jobs"
alias ls="ls -F"
alias p="projects"
alias ..="cd .."
alias sha256sum="gsha256sum"

# Completion for `bin/git-changed-files`
__git_changed_files() {
  local cmd="git changed-files"
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval "$cmd" | fzf --height 40% --reverse | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

_git_changed_files() {
  LBUFFER="${LBUFFER}$(__git_changed_files)"
  local ret=$?
  zle reset-prompt
  return $ret
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

# Inside tmux(1) - run builtin ssh, rename the window to the hostname if it is a
# known host in ssh_config(5)
# Outside tmux(1) - run builtin ssh.
ssh() {
  hostname="$@"
  previous_window_name=""
  original_ssh=$(whence -p ssh)
  known_hosts=$(grep -E "^Host" ~/.ssh/config | cut -d" " -f 2)
  is_known_host=$(echo $known_hosts | grep -Fq -- "$hostname"; echo $?)

  if [ -n "$TMUX" ] && [ "$is_known_host" = "0" ]; then
    previous_window_name=$(tmux display-message -p "#W")
    tmux rename-window "$hostname"

    $original_ssh "$@"
  else
    $original_ssh "$@"
  fi

  [ -n "$previous_window_name" ] && tmux rename-window "$previous_window_name"
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

_source_if_available() {
  file_to_be_sourced="$1"

  [ -e "$file_to_be_sourced" ] && source "$file_to_be_sourced"
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

_source_if_available "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
_source_if_available "$HOME/.nix-profile/share/fzf/completion.zsh"
_source_if_available "$HOME/.nix-profile/asdf/asdf.sh"
_source_if_available "$HOME/.nix-profile/share/zsh/site-functions/_asdf"
PATH=".git/safe/../../bin:$PATH"

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

# keybindings
_source_if_available "$HOME/.nix-profile/share/fzf/key-bindings.zsh"

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey -M vicmd '^X^e' edit-command-line
bindkey -M viins "^q" push-line-or-edit
bindkey -M viins '\e_' insert-last-word
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' history-beginning-search-forward-end
bindkey -M viins '^P' history-beginning-search-backward-end
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins '^X^G' _git_changed_files

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

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
