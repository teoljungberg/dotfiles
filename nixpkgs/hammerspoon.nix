# Taken from Burke Libbey:
# https://github.com/burke/b/blob/master/src/apps/hammerspoon.nix
{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "hammerspoon";
  version = "0.9.76";

  src = fetchzip {
    url =
      "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.76/Hammerspoon-0.9.76.zip";
    sha256 = "081m6wzljq82p883cwqpk1ka1j7qydhq0b4h47hvbbdjwd7iynh4";
  };

  installPhase = ''
    mkdir -p $out/Applications/Hammerspoon.app
    mv ./* $out/Applications/Hammerspoon.app
    chmod +x "$out/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon"
  '';

  meta = {
    description = "Staggeringly powerful macOS desktop automation with Lua";
    license = stdenv.lib.licenses.mit;
    homepage = "https://www.hammerspoon.org";
    platforms = stdenv.lib.platforms.darwin;
  };
}
