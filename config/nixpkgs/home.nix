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
  diff-highlight = pkgs.callPackage ./../../nixpkgs/diff-highlight.nix { };
  gitsh = pkgs.callPackage ./../../nixpkgs/gitsh.nix { };
  ruby-install = pkgs.callPackage ./../../nixpkgs/ruby-install.nix { };
  setrb = pkgs.callPackage ./../../nixpkgs/setrb.nix { };
in
{
  programs.home-manager.enable = true;

  home.homeDirectory = user.user.directory;
  home.stateVersion = "21.05";
  home.username = user.user.name;

  home.packages = with pkgs; [
    autoconf
    automake
    awscli2
    bat
    comma
    coreutils-prefixed
    diff-highlight
    fzf
    ghq
    git
    gitAndTools.gh
    gitAndTools.hub
    gitsh
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
