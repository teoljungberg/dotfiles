{pkgs, ...}: let
  overlays = ./../../../nixpkgs/overlays.nix;
  vim = pkgs.vim_configurable.override {
    ruby = pkgs.ruby_3_0;

    config.vim.gui = false;
  };
in {
  nixpkgs.overlays = import overlays;

  programs.home-manager.enable = true;

  home.homeDirectory = "/home/teo";
  home.stateVersion = "21.11";
  home.username = "teo";

  home.packages = with pkgs; [
    _1password
    autoconf
    automake
    fzf
    git
    gitAndTools.gh
    gitAndTools.hub
    gitAndTools.hut
    gitsh
    gnumake
    gnupg
    heroku
    jq
    lim
    mosh
    neovim
    nixpkgs-fmt
    pgformatter
    pkg-config
    rclone
    rcm
    ripgrep
    s3cmd
    setrb
    shellcheck
    shfmt
    tarsnap
    tmux
    universal-ctags
    vim
    vim-vint
    wget
    zsh
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
