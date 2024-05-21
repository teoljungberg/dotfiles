{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  runCommand ? pkgs.runCommand,
  neovim ? pkgs.neovim,
}: let
  src =
    if builtins.pathExists "${neovim}/share/nvim/runtime/macros/less.sh"
    then "${neovim}/share/nvim/runtime/macros/less.sh"
    else builtins.throw "No less macro found inside ${neovim}";
in
  runCommand "lim" {} ''
    mkdir -p $out/bin

    cp ${src} $out/bin/lim
  ''
