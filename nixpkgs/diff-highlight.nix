{ pkgs ? (import <nixpkgs> { })
, runCommand ? pkgs.runCommand
, git ? pkgs.git
}:

runCommand "diff-highlight" { } ''
  mkdir -p $out/bin
  ln -s \
    ${git}/share/git/contrib/diff-highlight/diff-highlight \
    $out/bin/diff-highlight
''
