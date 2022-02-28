# Taken from Burke Libbey:
# https://github.com/burke/b/blob/master/src/apps/hammerspoon.nix
{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
, fetchzip ? pkgs.fetchzip
}:

stdenv.mkDerivation {
  pname = "hammerspoon";
  version = "0.9.93";

  src = fetchzip {
    url = "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.93/Hammerspoon-0.9.93.zip";
    sha256 = "OMxINMxBoLV/jf8PV0PUjULuI9OGHRd6x9v7m1uwzmc=";
  };

  installPhase = ''
    mkdir -p $out/Applications/Hammerspoon.app
    mv ./* $out/Applications/Hammerspoon.app
    chmod +x "$out/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon"
  '';
}
