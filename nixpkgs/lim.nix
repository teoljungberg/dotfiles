{ pkgs ? (import <nixpkgs> { })
, runCommand ? pkgs.runCommand
, vim ? pkgs.vim
}:

runCommand "lim" { } ''
  mkdir -p $out/bin

  ln -s ${vim}/share/vim/vim82/macros/less.sh $out/bin/lim
''
