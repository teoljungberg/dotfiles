{
  pkgs ? (import <nixpkgs> {}),
  viAlias ? false,
  vimAlias ? false,
  useNightly ? false,
}: let
  inherit (pkgs) stdenv lib;

  version =
    if useNightly
    then "nightly"
    else "0.10.1";

  src =
    if useNightly
    then
      if stdenv.hostPlatform.system == "aarch64-darwin"
      then
        pkgs.fetchurl {
          url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz";
          sha256 = lib.fakeSha256;
        }
      else throw "Unsupported platform for nightly"
    else if stdenv.hostPlatform.system == "aarch64-darwin"
    then
      pkgs.fetchurl {
        url = "https://github.com/neovim/neovim/releases/download/v${version}/nvim-macos-arm64.tar.gz";
        sha256 = "4b322a8da38f0bbdcdcc9a2b224a7b5267f0b1610b7345cb880d803e03bb860b";
      }
    else throw "Unsupported platform for ${version}";
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
