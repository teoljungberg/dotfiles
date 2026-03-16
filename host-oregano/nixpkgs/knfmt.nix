{
  pkgs ? import <nixpkgs> { },
  stdenv ? pkgs.stdenv,
  lib ? pkgs.lib,
}:
let
  version = "5.1.2";
in
stdenv.mkDerivation rec {
  pname = "knfmt";
  inherit version;

  src = fetchTarball {
    url = "https://github.com/mptre/knfmt/releases/download/v${version}/knfmt-${version}.tar.gz";
    sha256 = "00ii9arbknqb2w9isj261vg35jxad1xnm5s595431nl52i5nhg82";
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
