{ config, pkgs, ... }:
let
  callPackage = pkgs.callPackage;

  user = import ./../../nixpkgs/user.nix;

  asdf = callPackage "${user.user.directory}/.nixpkgs/asdf.nix" { };
  comma = callPackage "${user.user.directory}/.nixpkgs/comma.nix" { };
  setrb = callPackage "${user.user.directory}/.nixpkgs/setrb.nix" { };
in {
  programs.home-manager.enable = true;

  home.homeDirectory = user.user.directory;
  home.stateVersion = "21.05";
  home.username = user.user.name;

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
