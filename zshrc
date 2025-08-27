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

export BUNDLE_FORCE_RUBY_PLATFORM=1
export BUNDLE_IGNORE_FUNDING_REQUESTS=1
export BUNDLE_PATH=".bundle/"
export DIRENV_LOG_FORMAT=
export DISABLE_SPRING=1
export EDITOR="$VISUAL"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent::1"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export MANWIDTH=80
export NIX_DIRENV_FALLBACK_NIX=
export NIX_SHELL_PRESERVE_PROMPT=1
export NO_COLOR=1
export PAGER="less -R"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export RPS1=""
export RUBOCOP_OPTS="--no-color"
export RUBY_DEBUG_NO_COLOR=1
export SPEC_OPTS="--no-color"
export THOR_SHELL="Basic"

if [ -z "$TMUX" ]; then
  export TERM="xterm-256color"
fi

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

_source_if_available "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
_source_if_available "$HOME/.nix-profile/share/fzf/completion.zsh"
_source_if_available "$HOME/.fzf/shell/completion.zsh"
PATH=".git/safe/../../bin:$PATH"

if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

stty -ixon

bindkey -v

autoload edit-command-line
zle -N edit-command-line

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
  [ -n "$SSH_TTY" ] && PS1+="%n@%m " # Add user@host, if in ssh(1)
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
    print -Pn "\a"
  else
    $@
    print -Pn "\a"
  fi
}

setup_setrb() {
  command -v setrb >/dev/null && \
    [ -z "$DISABLE_SETRB" ] && \
    [ -z "$SETRB_PATH_ADDITIONS" ] &&
    ([ -f .ruby-version ] || [ -f .tool-versions ]) && \
    eval "$(setrb -w0 2>/dev/null)"
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
  setup_setrb
}

_source_if_available "$HOME/.zshrc.local"
