{ pkgs ? (import <nixpkgs> { })
, ...
}:

# https://status.nixos.org
# with import
#   (fetchTarball "https://github.com/NixOS/nixpkgs/archive/COMMIT_SHA.tar.gz")
#   { };

let
  user = import ./../../nixpkgs/user.nix { };

  comma = pkgs.callPackage ./../../nixpkgs/comma.nix { };
  setrb = pkgs.callPackage ./../../nixpkgs/setrb.nix { };
  ruby-install = pkgs.callPackage ./../../nixpkgs/ruby-install.nix { };
in
{
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
    nixpkgs-fmt
    pgformatter
    pkg-config
    rcm
    ripgrep
    ruby-install
    setrb
    shellcheck
    tmux
    universal-ctags
    vim
    vim-vint
    zsh
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
