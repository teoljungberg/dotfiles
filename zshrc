autoload -U compinit && compinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook

setopt globdots
setopt nobeep
setopt no_bg_nice
setopt alwaystoend
setopt hist_ignore_all_dups inc_append_history
setopt prompt_sp
setopt auto_cd

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export DIRENV_LOG_FORMAT=
export EDITOR="vim"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export HEROKU_COLOR=0
export HEROKU_LOGS_COLOR=0
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-F -X -R"
export NIX_PATH="darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$NIX_PATH"
export NIX_PATH="darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH"
export NIX_PATH="home-manager=$HOME/.nix-defexpr/channels/home-manager:$NIX_PATH"
export NO_COLOR=1
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export RPS1=""
export RUBY_DEBUG_NO_COLOR=1
export RUBOCOP_OPTS="--no-color"
export THOR_SHELL=Basic

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
if [ -e "$HOME/.nix-profile/share/git/contrib/completion/git-completion.zsh" ]; then
  zstyle ':completion:*:*:git:*' script $HOME/.nix-profile/share/git/contrib/completion/git-completion.zsh
fi

alias b="bundle exec"
alias j="jobs"
alias ls="ls -F"
alias p="projects"

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

# Inside tmux(1) - run builtin clear and clear tmux history.
# Outside tmux(1) - run builtin clear.
clear() {
  local original_clear=$(whence -p clear)

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
  local hostname="$@"
  local previous_window_name=""
  local original_ssh=$(whence -p ssh)
  local known_hosts=""
  if [ -e "$HOME/.ssh/config" ]; then
    local known_hosts=$(grep -E "^Host" "$HOME/.ssh/config" | cut -d" " -f 2)
  fi
  local is_known_host=$(echo $known_hosts | grep -Fq -- "$hostname"; echo $?)

  if [ -n "$TMUX" ] && [ "$is_known_host" = "0" ]; then
    previous_window_name=$(tmux display-message -p "#W")
    tmux rename-window -t "$TMUX_PANE" "$hostname"

    $original_ssh "$@"
  else
    $original_ssh "$@"
  fi

  [ -n "$previous_window_name" ] && \
    tmux rename-window -t "$TMUX_PANE" "$previous_window_name"
}

# No arguments: `git status`
# With arguments: acts like `git`
git() {
  local original_git=$(whence -p git)

  if [ $# -gt 0 ]; then
    $original_git "$@"
  else
    $original_git status -sb
  fi
}

rename_tab_to_current_dir() {
  print -Pn "\\033]0;$(title_name)\\007"
}

rename_tmux_window_to_current_dir() {
  if [ -n "$TMUX" ] && [ -z "$VIM_TERMINAL" ]; then
    tmux rename-window -t "$TMUX_PANE" "$(title_name)"
  fi
}

refresh_tmux_environment_variables() {
  if [ -n "$TMUX" ]; then
    export $(tmux show-environment | grep "^THEME") > /dev/null
  fi
}

git_branch() {
  local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  [ -n "$branch_name" ] && echo "$branch_name "
}

projects() {
  local root=$(ghq root)
  local result=$(ghq list | fzf -q "$*")

  [ -n "$result" ] && cd "$root/$result"
}

_source_if_available() { [ -e "$1" ] && source "$1" }

theme() {
  local usage="theme <light|dark>"
  local new_style=""

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
      echo >&2 "$usage"
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
  local style=$(defaults read -g AppleInterfaceStyle 2> /dev/null)

  if [ "$style" = "Dark" ]; then
    export THEME=dark
  else
    export THEME=light
  fi
fi

_source_if_available "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
_source_if_available "$HOME/.nix-profile/share/fzf/completion.zsh"

if command -v kitty >/dev/null; then
  kitty + complete setup zsh | source /dev/stdin
fi

if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

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
bindkey -M viins '^X^e' edit-command-line
bindkey -M viins "^q" push-line-or-edit
bindkey -M viins '\e_' insert-last-word
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins  -s '^G' '| grep '
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins '^X^G' _git_changed_files
bindkey -M viins '^X^N' history-beginning-search-forward-end
bindkey -M viins '^X^P' history-beginning-search-backward-end

command -v fzf 1>/dev/null && bindkey -M viins '^X^R' fzf-history-widget

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

title_name() {
  print -Pn "%20<...<% %2c%<"
}

set_prompt() {
  PROMPT="%2c $(git_branch_color)$(git_branch)%{$reset_color%}%(1j.%j .)%# "

  [ -n "$SSH_CONNECTION" ] && \
    PROMPT="%2c@%m $(git_branch_color)$(git_branch)%{$reset_color%}%(1j.%j .)%# "
}

setup_setrb() {
  which setrb >/dev/null && \
    [ -z "$SETRB_PATH_ADDITIONS" ] &&
    ([ -f .ruby-version ] || [ -f .tool-versions ]) && \
    eval "$(setrb -w0 2>/dev/null)"
}

preexec() {
  refresh_tmux_environment_variables
}

precmd() {
  rename_tmux_window_to_current_dir
  rename_tab_to_current_dir
  set_prompt
  setup_setrb
}

_source_if_available "$HOME/.zshrc.local"
