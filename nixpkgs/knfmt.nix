{
  pkgs ? import <nixpkgs> { },
  stdenv ? pkgs.stdenv,
  lib ? pkgs.lib,
}:
let
  version = "4.5.0";
in
stdenv.mkDerivation rec {
  pname = "knfmt";
  inherit version;

  src = fetchTarball {
    url = "https://github.com/mptre/knfmt/releases/download/v${version}/knfmt-${version}.tar.gz";
    sha256 = "052p2nrrxf64fjdy9b840k2yw3kg0nsz57w18ih4wfs2dqdx8fs7";
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
