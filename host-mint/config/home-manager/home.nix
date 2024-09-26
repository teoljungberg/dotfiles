{ config, pkgs, ... }:
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
    fzf
    git
    gitAndTools.gh
    gitAndTools.hub
    gnupg
    heroku-aarch64-darwin
    jq
    knfmt
    lim
    mosh
    nixfmt-rfc-style
    pgformatter
    pkg-config
    rcm
    ripgrep
    ripper-tags
    s3cmd
    shellcheck
    shfmt
    stylua
    t-neovim
    tailscale
    tmux
    universal-ctags
    vim-vint
    zsh
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
