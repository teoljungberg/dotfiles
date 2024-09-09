autoload -U compinit && compinit

setopt alwaystoend
setopt auto_cd
setopt globdots
setopt hist_ignore_all_dups
setopt inc_append_history
setopt no_bg_nice
setopt print_exit_value
setopt prompt_sp

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

if command -v nvim > /dev/null 2>&1; then
  export VISUAL="nvim"
else
  export VISUAL="vim"
fi

export DIRENV_LOG_FORMAT=
export DISABLE_SPRING=1
export EDITOR="$VISUAL"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export HEROKU_COLOR=0
export HEROKU_LOGS_COLOR=0
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export NIX_DIRENV_FALLBACK_NIX=
export NIX_SHELL_PRESERVE_PROMPT=1
export NO_COLOR=1
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export RPS1=""
export RUBOCOP_OPTS="--no-color"
export RUBY_DEBUG_NO_COLOR=1
export SPEC_OPTS="--no-color"
export TERM="xterm-256color"
export THOR_SHELL="Basic"

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select
zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}
if [ -e "$HOME/.nix-profile/share/git/contrib/completion/git-completion.zsh" ]; then
  zstyle ':completion:*:*:git:*' script $HOME/.nix-profile/share/git/contrib/completion/git-completion.zsh
fi

alias b="bundle exec"
alias j="jobs"
alias ls="ls -F"

# Completion for `bin/git-changed-files`
__git_changed_files() {
  local cmd="git changed-files"
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval "$cmd" | fzf --height 40% --reverse | while read item; do
    echo -n "${(q)item} "
  done
  local result=$?
  echo
  return $result
}

_git_changed_files() {
  LBUFFER="${LBUFFER}$(__git_changed_files)"
  local result=$?
  zle reset-prompt
  return $result
}
zle -N _git_changed_files

# Inside tmux(1) - run builtin clear and clear tmux history.
# Outside tmux(1) - run builtin clear.
clear() {
  if [ -n "$TMUX" ]; then
    command clear && tmux clear-history
  else
    command clear
  fi
}

new-window() {
  if [ -n "$TMUX" ]; then
    tmux new-window "$@"
  elif command -v kitty > /dev/null 2>&1; then
    kitty @ launch --type=tab zsh 1>/dev/null
  fi
}
zle -N new-window

# No arguments: `git status`
# With arguments: acts like `git`
git() {
  if [ $# -gt 0 ]; then
    command git "$@"
  else
    command git status -sb
  fi
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
    export THEME="$new_style"
  fi

  if command -v kitty > /dev/null 2>&1; then
    kitty +kitten themes --reload-in=all "whitescale-$THEME"
  fi

  if [ -n "$TMUX" ]; then
    tmux set-environment THEME "$THEME"
    tmux source-file "$HOME/.tmux.conf"
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

if [ -z "$THEME" ]; then
  export THEME="light"
fi

if [ $(uname -s) = "Darwin" ]; then
  if [ "$(defaults read -g AppleInterfaceStyle 2> /dev/null)" = "Dark" ]; then
    export THEME="dark"
  else
    export THEME="light"
  fi
fi

_source_if_available "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
_source_if_available "$HOME/.nix-profile/share/fzf/completion.zsh"
_source_if_available "$HOME/.fzf/shell/completion.zsh"
PATH=".git/safe/../../bin:$PATH"

if command -v kitty > /dev/null 2>&1; then
  kitty + complete setup zsh | source /dev/stdin
fi

if command -v direnv > /dev/null 2>&1; then
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
_source_if_available "$HOME/.fzf/shell/key-bindings.zsh"

if command -v fzf > /dev/null 2>&1; then
  for keymap in viins vicmd; do
    bindkey -M "$keymap" -r "^R"
    bindkey -M "$keymap" -r "^T"
    bindkey -M "$keymap" -r "^[c"
  done
  unset keymap

  bindkey -M viins '^T' fzf-file-widget
  bindkey -M viins '^X^R' fzf-history-widget
fi

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
bindkey -M viins '^N' history-beginning-search-forward-end
bindkey -M viins '^P' history-beginning-search-backward-end
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins '^X^G' _git_changed_files

bindkey -M viins '^[[A' history-beginning-search-backward-end
bindkey -M viins '^[[B' history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

for keymap in viins vicmd; do
  bindkey -M "$keymap" "$terminfo[kf12]" new-window
done
unset keymap

git_branch() {
  local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
  [ -n "$branch_name" ] && print -Pn "%32<...<% $branch_name %< "
}

prompt_directory() {
  echo "%20<...<%~%<<"
}

set_prompt() {
  if [ -n "$SSH_TTY" ]; then
    PS1="$(prompt_directory) %n@%m $(git_branch)%(1j.%j .)%# "
  else
    PS1="$(prompt_directory) $(git_branch)%(1j.%j .)%# "
  fi
}

bell() {
  if [ $# -eq 0 ]; then
    cat
    print -Pn "\a"
  else
    $@
    print -Pn "\a"
  fi
}

set_title() {
  if [ -n "$SSH_TTY" ]; then
    print -Pn "\e]2;%n@%m:$(prompt_directory)"
  else
    print -Pn "\e]2;%n:$(prompt_directory)"
  fi

  if [ -n "$1" ]; then
    print -Pnr " (%20>...>$1%>>)"
  fi

  print -Pn ' \a'
}

refresh_tmux_environment_variables() {
  if [ -n "$TMUX" ]; then
    export $(tmux show-environment | grep "^THEME") > /dev/null
  fi
}

preexec() {
  set_title "$@"
  refresh_tmux_environment_variables
}

precmd() {
  set_title "$@"
  set_prompt
}

_source_if_available "$HOME/.zshrc.local"
