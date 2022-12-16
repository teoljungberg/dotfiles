{ pkgs ? import <nixpkgs> { }
, ...
}:

let
  overlays = ./../../../nixpkgs/overlays.nix;
  user = import ./../../../nixpkgs/user.nix { inherit pkgs; };
  vim = pkgs.vim_configurable.override {
    ruby = pkgs.ruby_3_0;

    config.vim.gui = false;
  };
in
{
  nixpkgs.overlays = import overlays;

  programs.home-manager.enable = true;

  home.homeDirectory = user.directory;
  home.stateVersion = "21.11";
  home.username = user.name;

  home.packages = with pkgs; [
    _1password
    autoconf
    automake
    bat
    diff-highlight
    dropbox-cli
    fzf
    ghq
    git
    gitAndTools.gh
    gitAndTools.hub
    gitAndTools.hut
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
    tarsnap
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
