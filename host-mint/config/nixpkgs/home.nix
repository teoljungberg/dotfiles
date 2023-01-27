{ pkgs ? import <nixpkgs> { }
, ...
}:

let
  overlays = ./../../../nixpkgs/overlays.nix;
  user = import ./../../../nixpkgs/user.nix { inherit pkgs; };
in
{
  nixpkgs.overlays = import overlays;

  programs.home-manager.enable = true;

  home.homeDirectory = user.directory;
  home.stateVersion = "21.11";
  home.username = user.name;

  home.packages = with pkgs; [
    autoconf
    automake
    bat
    fzf
    ghq
    git
    gitAndTools.gh
    gitAndTools.hub
    gitsh
    gnupg
    heroku
    jq
    lim
    mosh
    neovim
    nixpkgs-fmt
    pgformatter
    pkg-config
    rcm
    ripgrep
    s3cmd
    setrb
    shellcheck
    shfmt
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