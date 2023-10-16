# Taken from Burke Libbey:
# https://github.com/burke/b/blob/master/src/apps/hammerspoon.nix
{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  fetchzip ? pkgs.fetchzip,
}: let
  version = "0.9.100";
in
  stdenv.mkDerivation rec {
    pname = "hammerspoon";
    inherit version;

    src = fetchzip {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/download/${version}/Hammerspoon-${version}.zip";
      sha256 = "Q14NBizKz7LysEFUTjUHCUnVd6+qEYPSgWwrOGeT9Q0=";
    };

    installPhase = ''
      mkdir -p $out/Applications/Hammerspoon.app
      mv ./* $out/Applications/Hammerspoon.app
      chmod +x "$out/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon"
    '';
  }
