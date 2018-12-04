# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# load our own completion functions

fpath=(
  $HOME/.zsh/completion
  /usr/local/share/zsh/site-functions
  /usr/local/share/zsh-completions
  $fpath
)

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

add_trusted_local_bin_to_path() {
  if [ -d "$PWD/.git/safe" ]; then
    prepend_to_path_without_duplication ".git/safe/../../bin"
  else
    remove_from_path ".git/safe/../../bin"
  fi
}

add-zsh-hook preexec "add_trusted_local_bin_to_path"

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
