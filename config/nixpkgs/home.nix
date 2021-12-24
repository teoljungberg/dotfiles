{ pkgs ? (import <nixpkgs> { overlays = import ./config/nixpkgs/overlays.nix; })
, ...
}:

let
  user = import ./../../nixpkgs/user.nix { };
in
{
  programs.home-manager.enable = true;

  home.homeDirectory = user.user.directory;
  home.stateVersion = "21.05";
  home.username = user.user.name;

  home.packages = with pkgs; [
    autoconf
    automake
    bat
    comma
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
    s3cmd
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
