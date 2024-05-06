{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  runCommand ? pkgs.runCommand,
  vim ? pkgs.vim,
}:
with lib; let
  src =
    if versionAtLeast vim.version "9.0"
    then "${vim}/share/vim/vim90/macros/less.sh"
    else if versionAtLeast vim.version "8.2"
    then "${vim}/share/vim/vim82/macros/less.sh"
    else builtins.throw "No less macro found inside ${vim}";
in
  runCommand "lim" {} ''
    mkdir -p $out/bin

    cp ${src} $out/bin/lim
  ''
