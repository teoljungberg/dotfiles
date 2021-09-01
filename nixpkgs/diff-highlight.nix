{ runCommand ? (import <nixpkgs> { }).runCommand
, git ? (import <nixpkgs> { }).git
}:

runCommand "diff-highlight" { } ''
  mkdir -p $out/bin
  ln -s \
    ${git}/share/git/contrib/diff-highlight/diff-highlight \
    $out/bin/diff-highlight
''
