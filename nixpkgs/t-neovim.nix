{
  pkgs ? (import <nixpkgs> { }),
  viAlias ? false,
  vimAlias ? false,
  useNightly ? false,
}:
let
  inherit (pkgs) stdenv lib;

  bundle =
    if useNightly then
      if stdenv.hostPlatform.system == "aarch64-darwin" then
        {
          version = "nightly";
          src = pkgs.fetchurl {
            url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz";
            sha256 = lib.fakeSha256;
          };
        }
      else
        throw "Unsupported platform for nightly"
    else if stdenv.hostPlatform.system == "aarch64-darwin" then
      {
        version = "0.10.2";
        src = pkgs.fetchurl {
          url = "https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-macos-arm64.tar.gz";
          sha256 = "zT4ul/7ihcQQFs7OUeZ+gXTfHcV3uJvAQGOyBozNrqA=";
        };
      }
    else
      throw "Unsupported platform";
in
stdenv.mkDerivation {
  inherit (bundle) version src;
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
