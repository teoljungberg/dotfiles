# teoljungberg/dotfiles

## rcrc(5)

```
DOTFILES_DIRS="$HOME/src/github.com/teoljungberg/dotfiles"
COPY_ALWAYS="git_template/info/projections.json"
EXCLUDES="README.md ./CLAUDE.md ./AGENTS.md *.local.md result rcrc Session.vim"
HOSTNAME="A_HOST"
```

## NixOS

1. `cp /etc/nixos/configuration.nix{,.bak}`
1. Modify `/etc/nixos/configuration.nix` to your hearts content. Reboot server.
1. `ln -sf $(pwd)/host-A_HOST/nixpkgs/nixos-configuration.nix /etc/nixos/configuration.nix`
1. Add [nix channels](#nix-channels)

### Nix Channels

```
% nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/NIXPKGS_RELEASE.tar.gz
nixpkgs https://nixos.org/channels/nixos-NIXPKGS_RELEASE
```

## crontab(5)

```
LANG="en_US.UTF-8"
PATH=$HOME/.nix-profile/bin:/usr/bin:/bin

30 9 * * *	$HOME/src/github.com/teoljungberg/dotfiles/bin/update-vim-plugins
```
