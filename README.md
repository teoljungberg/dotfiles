# Setup

I use [rcm](http://github.com/thoughtbot/rcm) to manage my dotfiles.

## Cron

Add the `cron/crontab-teoljungberg` to your own `crontab(1)`:

```sh
% crontab - < cron/crontab-teoljungberg
```

## FZF

I use [fzf](http://github.com/junegunn/fzf) to act as my fuzzy-matcher.

## Nix

1. Install [nix]
1. Install [nix-darwin]
1. Install [home-manager]
1. Add nix channels.

```
% cat ~/.nix-channels
https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
https://nixos.org/channels/nixpkgs-unstable unstable
```

```sh
% darwin-rebuild switch -I darwin-config=$HOME/src/dotfiles/nixpkgs/darwin-configuration.nix
% home-manager switch -f $HOME/src/dotfiles/config/nixpkgs/home.nix
```

[nix]: https://nixos.org/download.html
[nix-darwin]: https://github.com/LnL7/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
