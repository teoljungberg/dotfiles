# teoljungberg/dotfiles

## rcm(1)

```
% cat ~/.rcrc
DOTFILES_DIRS="$HOME/src/github.com/teoljungberg/dotfiles"
EXCLUDES="*.md cron/* result rcrc"
HOSTNAME="A_HOST"
```

## Nix

```
% nix-channel --list
nixpkgs https://nixos.org/channels/nixos-NIXPKGS_RELEASE
home-manager https://github.com/nix-community/home-manager/archive/NIXPKGS_RELEASE.tar.gz
```

If on Darwin:

```
~ % nix-channel --list
darwin https://github.com/LnL7/nix-darwin/archive/master.tar.gz
home-manager https://github.com/nix-community/home-manager/archive/release-NIXPKGS_RELEASE.tar.gz
nixpkgs https://nixos.org/channels/nixpkgs-NIXPKGS_RELEASE-darwin
```

### Darwin

1. Install [nix]
1. Install [nix-darwin]
1. Install [home-manager]
1. Add nix channels.

```
% darwin-rebuild switch -I darwin-config=$(pwd)/nixpkgs/darwin-configuration.nix
```

### NixOS

1. `cp /etc/nixos/configuration.nix{,.bak}`
1. Modify `/etc/nixos/configuration.nix` to your hearts content. Reboot server.
1. `ln -sf $(pwd)/host-A_HOST/nixpkgs/nixos-configuration.nix /etc/nixos/configuration.nix`
1. Add nix channels.

## Cron

Add the `cron/crontab-teoljungberg` to your own `crontab(1)`:

```
% crontab - < cron/crontab-teoljungberg
```

[nix]: https://nixos.org/manual/nix/stable/installation/installing-binary.html
[nix-darwin]: https://github.com/LnL7/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
[nixos-infect]: https://github.com/elitak/nixos-infect
