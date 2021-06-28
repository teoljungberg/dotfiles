# Setup

I use [rcm](http://github.com/thoughtbot/rcm) to manage my dotfiles.

## Cron

Add the `cron/crontab-teoljungberg` to your own `crontab(1)`:

```
% crontab - < cron/crontab-teoljungberg
```

## FZF

I use [fzf](http://github.com/junegunn/fzf) to act as my fuzzy-matcher.

## Nix

```
% cat ~/.nix-channels
https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
https://nixos.org/channels/nixpkgs-unstable unstable
```

### Darwin

1. Install [nix]
1. Install [nix-darwin]
1. Install [home-manager]
1. Add nix channels.

```
% darwin-rebuild switch -I darwin-config=$HOME/src/dotfiles/nixpkgs/darwin-configuration.nix
% home-manager switch -f $HOME/src/dotfiles/config/nixpkgs/home.nix
```

### NixOS

1. Install NixOS on i.e DigitalOcean using [nixos-infect].

  ```
  # curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | \
    NIX_CHANNEL=nixos-20.09 PROVIDER=digitalocean NO_REBOOT=1 bash -x
  ```

1. Modify `/etc/nixos/configuration.nix` to your hearts content. Reboot server.
1. `cp /etc/nixos/configuration.nix{,.bak}`
1. `ln -sf $HOME/dotfiles/nixpkgs/nixos-configuration.nix /etc/nixos/configuration.nix`
1. Add nix channels.

[nix]: https://nixos.org/manual/nix/stable/#sect-macos-installation
[nix-darwin]: https://github.com/LnL7/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
[nixos-infect]: https://github.com/elitak/nixos-infect
