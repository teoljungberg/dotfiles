{ pkgs ? import <nixpkgs> { }
, ...
}:

let
  user = import <t-nixpkgs/user.nix> { inherit pkgs; };
in
{
  nixpkgs.overlays = import <t-nixpkgs/overlays.nix>;

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
    ruby-install
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
