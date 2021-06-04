{ pkgs, ... }:

# https://status.nixos.org
# with import
#   (fetchTarball "https://github.com/NixOS/nixpkgs/archive/COMMIT_SHA.tar.gz")
#   { };

let
  user = import ./../../nixpkgs/user.nix { };

  asdf = pkgs.callPackage "${user.user.directory}/.nixpkgs/asdf.nix" { };
  comma = pkgs.callPackage "${user.user.directory}/.nixpkgs/comma.nix" { };
  setrb = pkgs.callPackage "${user.user.directory}/.nixpkgs/setrb.nix" { };
in {
  programs.home-manager.enable = true;

  home.homeDirectory = user.user.directory;
  home.stateVersion = "21.05";
  home.username = user.user.name;

  home.packages = with pkgs; [
    autoconf
    automake
    comma
    coreutils-prefixed
    fzf
    git
    gitAndTools.gh
    gitAndTools.hub
    gnupg
    heroku
    jq
    nixfmt
    openssl.dev
    pgformatter
    pkg-config
    rcm
    readline.dev
    ripgrep
    setrb
    shellcheck
    tmux
    universal-ctags
    vim
    zsh
  ];

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;
}
