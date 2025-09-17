{
  pkgs ? import <nixpkgs> { },
  stdenv ? pkgs.stdenv,
  lib ? pkgs.lib,
}:
let
  version = "5.0.0";
in
stdenv.mkDerivation rec {
  pname = "knfmt";
  inherit version;

  src = fetchTarball {
    url = "https://github.com/mptre/knfmt/releases/download/v${version}/knfmt-${version}.tar.gz";
    sha256 = "0r0f4saafhvymhs7jclgc2rg18dwin6y9m0hhhkxbhwii6ggqjax";
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
