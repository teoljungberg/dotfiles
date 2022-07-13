{ pkgs ? import <nixpkgs> { }
, ...
}:

let
  user = import ./../../nixpkgs/user.nix { };
in
{
  nixpkgs.overlays = import ./overlays.nix;

  programs.home-manager.enable = true;

  home.homeDirectory = user.directory;
  home.stateVersion = "21.11";
  home.username = user.name;

  home.packages = with pkgs; [
    autoconf
    automake
    bat
    diff-highlight
    fzf
    ghq
    git
    gitAndTools.gh
    gitAndTools.hub
    gitsh
    heroku
    jq
    lim
    neovim
    nixpkgs-fmt
    pgformatter
    rcm
    ripgrep
    ruby-install
    s3cmd
    setrb
    shellcheck
    shfmt
    tmux
    universal-ctags
    vim
    vim-vint
    zsh
  ] ++ (
    if stdenv.isLinux then
      [
        pkgs.gnupg
        pkgs.pkg-config
      ]
    else
      [ ]
  );

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
