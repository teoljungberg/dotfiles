{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  lib ? pkgs.lib,
}: let
  version = "4.3.0";
in
  stdenv.mkDerivation rec {
    pname = "knfmt";
    inherit version;

    src = fetchTarball {
      url = "https://github.com/mptre/knfmt/releases/download/v${version}/knfmt-${version}.tar.gz";
      sha256 = "0hwq5s6r46n5ngjz7ljcgc7p4mcssvhc54zva7fslg6x7zgwd3b3";
    };

    buildPhase = ''
      PREFIX=$out ./configure
    '';

    meta = {
      description = "kernel normal form formatter";
      license = lib.licenses.isc;
      homepage = "https://github.com/mptre/knfmt";
      platforms = lib.platforms.unix;
    };
  }
