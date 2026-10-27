autoload -U compinit
_fresh_zcompdump=(~/.zcompdump(N.mh-24))
if [ -n "$_fresh_zcompdump" ]; then
  compinit -C
else
  compinit
  # compinit leaves an unchanged dump alone, so mark it as checked today
  touch ~/.zcompdump
  zcompile ~/.zcompdump
fi
unset _fresh_zcompdump
autoload -U add-zsh-hook

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
  alias vim="nvim"
fi

export BUNDLE_IGNORE_FUNDING_REQUESTS=1
export BUNDLE_PATH=".bundle/"
export DIRENV_LOG_FORMAT=
export DISABLE_SPRING=1
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_COLOR=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ENV_HINTS=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export MANWIDTH=80
export NO_COLOR=1
export NPM_CONFIG_FUND=false
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export RPS1=""
export RUBOCOP_OPTS="--no-color"
export RUBY_DEBUG_NO_COLOR=1
export SPEC_OPTS="--no-color"
export THOR_SHELL="Basic"

if [ -e "/opt/homebrew/bin/brew" ]; then
  if ! which brew 1>/dev/null; then
    eval "$(brew shellenv)"
  fi

  export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
fi

# Ghostty sets TERM=xterm-ghostty itself; only override other terminals
# https://ghostty.org/docs/help/terminfo
if [ -z "$TMUX" ] && [ "$TERM" != "xterm-ghostty" ]; then
  export TERM="xterm-256color"
fi

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select
zstyle -e ':completion:*:*:git:*' user-commands 'reply=(${${(M)${(k)commands}:#git-*}/git-/})'

if [ -e "/opt/homebrew/share/zsh/site-functions/_git" ]; then
  zstyle ':completion:*:*:git:*' script /opt/homebrew/share/zsh/site-functions/_git
fi

_gem_ctags() {
  if [ -f Gemfile ]; then
    compadd $(bundle list --name-only 2>/dev/null)
  fi
}
compdef _gem_ctags gem-ctags

alias b="bundle exec"
alias j="jobs"
alias ls="ls -F"

alias p="cd_projects"

# Completion for `bin/git-changed-files`
__git_changed_files() {
  if ! command -v fzf >/dev/null 2>&1; then
    echo >&2 "fzf(1) is not installed."
    return 1
  fi
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

cd_projects() {
  local dir
  dir=$(projects "$@")
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

# No arguments: `git status`
# With arguments: acts like `git`
git() {
  if [ $# -gt 0 ]; then
    command git "$@"
  else
    command git status -sb
  fi
}

_run_and_rename_tmux_window() {
  local name="$1"
  shift
  if [ -n "$TMUX" ]; then
    tmux set-window-option automatic-rename off
    tmux rename-window "$name"
    {
      "$@"
    } always {
      tmux set-window-option automatic-rename on
    }
  else
    "$@"
  fi
}

# Define only commands that exist on PATH.
if command -v claude > /dev/null 2>&1; then
  # NO_COLOR strips every style from claude(1), selection highlights included.
  # A function-local NO_COLOR shadows the global one and is restored on return.
  claude() {
    local NO_COLOR
    unset NO_COLOR
    _run_and_rename_tmux_window "claude" command claude "$@"
  }
fi

if command -v pi > /dev/null 2>&1; then
  pi() {
    _run_and_rename_tmux_window "pi" command pi "$@"
  }
fi

_source_if_available() { [ -e "$1" ] && source "$1" }

_source_if_available "/opt/homebrew/opt/fzf/shell/completion.zsh"
_source_if_available "$HOME/.fzf/shell/completion.zsh"

# Switch Ruby to the new directory's `.ruby-version`; zshenv covers startup
if command -v rv > /dev/null 2>&1; then
  _rv_env() { eval "$(rv shell env zsh)" }
  add-zsh-hook chpwd _rv_env
fi

_prepend_binstubs() {
  case "$PATH" in
    .git/safe/../../bin:*) ;;
    *) PATH=".git/safe/../../bin:$PATH" ;;
  esac
}
preexec_functions+=("_prepend_binstubs")

if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if [ -t 0 ]; then
  stty -ixon
fi

bindkey -v

autoload edit-command-line
zle -N edit-command-line

_source_if_available "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
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
if command -v yank > /dev/null 2>&1; then
  bindkey -M viins  -s '^Y' '| yank '
fi


bindkey -M viins '^[[A' history-beginning-search-backward-end
bindkey -M viins '^[[B' history-beginning-search-forward-end

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

git_branch() {
  local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
  [ -n "$branch_name" ] && print -Pn "%32<...<% $branch_name %< "
}

prompt_directory() {
  echo "%20<...<%~%<<"
}

set_prompt() {
  # OSC-133
  local prompt_start=$'\e]133;A\e\\'
  local prompt_end=$'\e]133;B\e\\'
  # colors
  local reverse_color=$'\e[7m'
  local reset_color=$'\e[0m'

  PS1="%{${prompt_start}%}"          # Start with the prompt start sequence (OSC-133)
  PS1+="%{${reverse_color}%}"        # Set reverse color
  PS1+=$(prompt_directory)           # Add the current directory
  PS1+=" "                           # Add a space
  [ -n "$SSH_TTY$REX_SESSION" ] && PS1+="%n@%m " # Add user@host, if in ssh(1) or rex(1)
  PS1+=$(git_branch)                 # Add the git(1) branch
  PS1+="%(1j.%j .)"                  # Add job count, if any
  PS1+="%#"                          # Add the prompt character
  PS1+="%{${reset_color}%}"          # Reset color
  PS1+=" "                           # Add a space
  PS1+="%{${prompt_end}%}"           # End with the prompt end sequence (OSC-133)
}

bell() {
  if [ $# -eq 0 ]; then
    cat
    tput bel
  else
    $@
    tput bel
  fi
}

set_title() {
  if [ -n "$SSH_TTY$REX_SESSION" ]; then
    print -Pn "\e]2;%n@%m:$(prompt_directory)"
  else
    print -Pn "\e]2;%n:$(prompt_directory)"
  fi

  if [ -n "$1" ]; then
    # Escape `%` for `print -P`, and keep newlines out of the escape sequence
    local cmd="${1//\%/%%}"
    print -Pnr " (%20>...>${cmd//[[:cntrl:]]/?}%>>)"
  fi

  print -Pn ' \a'
}

mark_prompt() {
  print -n '\e]133;C\e\\'
}

preexec() {
  set_title "$@"
  mark_prompt
}

precmd() {
  set_title "$@"
  set_prompt
}

_source_if_available "$HOME/.zshrc.local"
