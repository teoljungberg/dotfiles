{ config, pkgs, ... }:
let
  user = import ./../../nixpkgs/user.nix { };

  asdf = pkgs.callPackage "${user.user.directory}/.nixpkgs/asdf.nix" { };
  comma = pkgs.callPackage "${user.user.directory}/.nixpkgs/comma.nix" { };
  setrb = pkgs.callPackage "${user.user.directory}/.nixpkgs/setrb.nix" { };
  nixpkgs-teo = import "${user.user.directory}/src/nixpkgs" { };
in {
  programs.home-manager.enable = true;

  home.homeDirectory = user.user.directory;
  home.stateVersion = "21.05";
  home.username = user.user.name;

  home.packages = with pkgs; [
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
