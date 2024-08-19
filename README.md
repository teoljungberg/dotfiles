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

### NixOS

1. `cp /etc/nixos/configuration.nix{,.bak}`
1. Modify `/etc/nixos/configuration.nix` to your hearts content. Reboot server.
1. `ln -sf $(pwd)/host-A_HOST/nixpkgs/nixos-configuration.nix /etc/nixos/configuration.nix`
1. Add [nix channels](#nix-channels)

## Nix Channels

```
% nix-channel --list
nixpkgs https://nixos.org/channels/nixos-NIXPKGS_RELEASE
home-manager https://github.com/nix-community/home-manager/archive/NIXPKGS_RELEASE.tar.gz
```

If on Darwin:

```
% nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/release-NIXPKGS_RELEASE.tar.gz
nixpkgs https://nixos.org/channels/nixpkgs-NIXPKGS_RELEASE-darwin
```

## Cron

Add the `cron/crontab-teoljungberg` to your own `crontab(5)`:

[nix]: https://determinate.systems/posts/determinate-nix-installer/
