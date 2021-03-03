# Taken from Burke Libbey:
# https://github.com/burke/b/blob/master/src/apps/hammerspoon.nix
{ lib ? (import <nixpkgs> { }).lib, stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "hammerspoon";
  version = "0.9.82";

  src = fetchzip {
    url =
      "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.82/Hammerspoon-0.9.82.zip";
    sha256 = "0ydg05cci0ycnin3mr1i1cmgr3233frh723hm90k2nymyl3ypmqz";
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
