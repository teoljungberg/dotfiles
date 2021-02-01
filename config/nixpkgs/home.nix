{ config, pkgs, ... }:
let
  callPackage = pkgs.callPackage;

  asdf = callPackage /Users/teo/src/dotfiles/nixpkgs/asdf.nix { };
  comma = callPackage /Users/teo/src/dotfiles/nixpkgs/comma.nix {};
  setrb = callPackage /Users/teo/src/dotfiles/nixpkgs/setrb.nix { };
in {
  programs.home-manager.enable = true;
  home.stateVersion = "20.03";

  home.packages = with pkgs; [
    asdf
    autoconf
    automake
    coreutils-prefixed
    comma
    fzf
    git
    gitAndTools.gh
    gitAndTools.hub
    gnupg
    heroku
    jq
    nixfmt
    openssl.dev
    pgformatter
    rcm
    readline.dev
    ripgrep
    setrb
    shellcheck
    tmux
    universal-ctags
    zsh
  ];

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;
}
