{
  pkgs ? import <nixpkgs> { },
}:
let
  neovim-nightly = pkgs.neovim-unwrapped.overrideAttrs (old: {
    pname = "neovim-nightly";
    version = "nightly";
    doInstallCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "nightly";
      hash = pkgs.lib.fakeHash;
    };
  });
  wrapped = pkgs.wrapNeovim neovim-nightly { };
in
pkgs.runCommand "nnvim" { } ''
  mkdir -p $out/bin
  mkdir -p $out/share/man/man1

  ln -s ${wrapped}/bin/nvim $out/bin/nnvim
  ln -s ${wrapped}/share/nvim $out/share/nnvim
  ln -s ${wrapped}/share/man/man1/nvim.1.gz $out/share/man/man1/nnvim.1.gz
''
