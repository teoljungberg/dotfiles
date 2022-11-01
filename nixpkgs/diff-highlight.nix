{ pkgs ? import <nixpkgs> { }
, runCommand ? pkgs.runCommand
, git ? pkgs.git
}:

let
  src =
    if builtins.pathExists "${git}/share/git/contrib/diff-highlight" then
      "${git}/share/git/contrib/diff-highlight/diff-highlight"
    else
      builtins.throw "No diff-highlight found inside ${git}";
in
runCommand "diff-highlight" { } ''
  mkdir -p $out/bin

  ln -s ${src} $out/bin/diff-highlight
''
