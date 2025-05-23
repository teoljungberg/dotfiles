# Taken from Burke Libbey:
# https://github.com/burke/b/blob/master/src/apps/hammerspoon.nix
{
  pkgs ? import <nixpkgs> { },
  stdenv ? pkgs.stdenv,
  fetchzip ? pkgs.fetchzip,
}:
let
  version = "1.0.0";
in
stdenv.mkDerivation rec {
  pname = "hammerspoon";
  inherit version;

  src = fetchzip {
    url = "https://github.com/Hammerspoon/hammerspoon/releases/download/${version}/Hammerspoon-${version}.zip";
    sha256 = "vqjYCzEXCYBx/gJ32ZNAioruVDy9ghftPAOFMDtYcc0=";
  };

  installPhase = ''
    mkdir -p $out/Applications/Hammerspoon.app
    mkdir -p $out/bin
    mkdir -p $out/share/man/man1
    mv ./* $out/Applications/Hammerspoon.app
    ln -s $out/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs $out/bin/hs
    ln -s $out/Applications/Hammerspoon.app/Contents/Resources/man/hs.man $out/share/man/man1/hs.1
    chmod +x "$out/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon"
  '';
}
