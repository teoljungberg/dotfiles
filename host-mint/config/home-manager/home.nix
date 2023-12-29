{pkgs, ...}: let
  overlays = ./../../../nixpkgs/overlays.nix;
in {
  nixpkgs.overlays = import overlays;

  programs.home-manager.enable = true;

  home.homeDirectory = "/Users/teo";
  home.stateVersion = "21.11";
  home.username = "teo";

  home.packages = with pkgs; [
    alejandra
    autoconf
    automake
    bat
    fzf
    git
    gitAndTools.gh
    gitAndTools.hub
    gnupg
    herokuDarwinArm
    jq
    knfmt
    lim
    mosh
    neovim
    pgformatter
    pkg-config
    rcm
    ripgrep
    ripper-tags
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
