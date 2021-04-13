{ config, pkgs, ... }:
let
  callPackage = pkgs.callPackage;

  asdf = callPackage ./../../nixpkgs/asdf.nix { };
  comma = callPackage ./../../nixpkgs/comma.nix { };
  setrb = callPackage ./../../nixpkgs/setrb.nix { };
in {
  programs.home-manager.enable = true;

  home.homeDirectory = "/Users/teo";
  home.stateVersion = "21.05";
  home.username = "teo";

  home.packages = with pkgs; [
    asdf
    autoconf
    automake
    comma
    coreutils-prefixed
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
    pkg-config
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
