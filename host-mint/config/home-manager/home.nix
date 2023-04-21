{ pkgs ? import <nixpkgs> { }
, ...
}:

let
  overlays = ./../../../nixpkgs/overlays.nix;
in
{
  nixpkgs.overlays = import overlays;

  programs.home-manager.enable = true;

  home.homeDirectory = "/Users/teo";
  home.stateVersion = "21.11";
  home.username = "teo";

  home.packages = with pkgs; [
    autoconf
    automake
    bat
    comma
    fzf
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
    tailscale
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
