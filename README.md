# teoljungberg/dotfiles

## rcm(1)

```
% cat ~/.rcrc
DOTFILES_DIRS="$HOME/src/github.com/teoljungberg/dotfiles"
EXCLUDES="*.md cron/* result rcrc"
HOSTNAME="A_HOST"
```

### Darwin

1. Install [nix]
1. Add [nix channels](#nix-channels)
```
% home-manager switch -f $(pwd)/host-A_HOST/config/home-manager/home.nix
```

[nix]: https://determinate.systems/posts/determinate-nix-installer/

### NixOS

1. `cp /etc/nixos/configuration.nix{,.bak}`
1. Modify `/etc/nixos/configuration.nix` to your hearts content. Reboot server.
1. `ln -sf $(pwd)/host-A_HOST/nixpkgs/nixos-configuration.nix /etc/nixos/configuration.nix`
1. Add [nix channels](#nix-channels)

## Nix Channels

```
% nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/NIXPKGS_RELEASE.tar.gz
nixpkgs https://nixos.org/channels/nixos-NIXPKGS_RELEASE
```

If on Darwin:

```
% nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/release-NIXPKGS_RELEASE.tar.gz
nixpkgs https://nixos.org/channels/nixpkgs-NIXPKGS_RELEASE-darwin
```

## Cron

```
LANG="en_US.UTF-8"
PATH=$HOME/.nix-profile/bin:/usr/bin:/bin

30 9 * * *	$HOME/src/github.com/teoljungberg/dotfiles/bin/update-vim-plugins
```
