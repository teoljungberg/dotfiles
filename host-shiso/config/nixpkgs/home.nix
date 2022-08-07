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
    mosh
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
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
