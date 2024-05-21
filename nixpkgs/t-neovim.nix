{
  pkgs ? (import <nixpkgs> {}),
  viAlias ? false,
  vimAlias ? false,
}: let
  inherit (pkgs) stdenv lib;

  version = "0.10.0";
  src =
    if stdenv.hostPlatform.system == "aarch64-darwin"
    then
      pkgs.fetchurl {
        url = "https://github.com/neovim/neovim/releases/download/v${version}/nvim-macos-arm64.tar.gz";
        sha256 = "4ARSrb4ekPuMLZvUGFWz9YW/bi2zG5w1RW1iU7ChUt0=";
      }
    else throw "Unsupported platform";
in
  stdenv.mkDerivation {
    inherit version src;
    name = "neovim";

    installPhase =
      ''
        mkdir -p $out/{bin,lib,share}
        cp -R bin/* $out/bin
        cp -R lib/* $out/lib
        cp -R share/* $out/share
      ''
      + lib.optionalString viAlias ''
        ln -s $out/bin/nvim $out/bin/vi
      ''
      + lib.optionalString vimAlias ''
        ln -s $out/bin/nvim $out/bin/vim
      '';
  }
