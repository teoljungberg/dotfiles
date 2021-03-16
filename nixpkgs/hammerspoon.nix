# Taken from Burke Libbey:
# https://github.com/burke/b/blob/master/src/apps/hammerspoon.nix
{ lib ? (import <nixpkgs> { }).lib, stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "hammerspoon";
  version = "0.9.86";

  src = fetchzip {
    url =
      "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.86/Hammerspoon-0.9.86.zip";
    sha256 = "196qnar404szhmg504bi4cwwpabmnxczks8j91n574qmn8b8nd9p";
  };

  installPhase = ''
    mkdir -p $out/Applications/Hammerspoon.app
    mv ./* $out/Applications/Hammerspoon.app
    chmod +x "$out/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon"
  '';

  meta = {
    description = "Staggeringly powerful macOS desktop automation with Lua";
    license = lib.licenses.mit;
    homepage = "https://www.hammerspoon.org";
    platforms = lib.platforms.darwin;
  };
}
