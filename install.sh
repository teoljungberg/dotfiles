#!/bin/sh

set -e
[ -n "$DEBUG" ] && set -ex

if [ -n "$SPIN" ]; then
  is_installed() {
    command -v "$1"
  }
  install() {
    sudo apt-get install -y "$1"
  }

  is_installed ctags || install ctags
  is_installed fzf || install fzf
  is_installed rcup || install rcm
  is_installed rg || install ripgrep

  rcup -d ~/dotfiles -x bundle/config -f

  git \
    config \
    --file ~/.gitconfig.local \
    --add \
    user.email \
    teo.ljungberg@shopify.com
  git \
    config \
    --file ~/.gitconfig.local \
    core.sshCommand \
    'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

  sh ~/dotfiles/cron/vim-plugins

  [ ! -d "~/.fzf" ] &&
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

  git \
    config \
    --file ~/.gitconfig.local \
    --remove
    core.sshCommand
fi
