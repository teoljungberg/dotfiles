{ pkgs ? (import <nixpkgs> { })
, stdenv ? pkgs.stdenv
, lib ? pkgs.lib
, fetchzip ? pkgs.fetchzip
}:

stdenv.mkDerivation {
  pname = "setrb";
  version = "0.3.1";

  src = fetchzip {
    url = "https://mike-burns.com/project/setrb/setrb-0.3.1.tar.gz";
    sha256 = "0wm7c3248c21qr8i7a0491i272qcyj1b338fxiw8r72ydnj5fxdj";
  };

  meta = {
    description = "setrb(1) switches Ruby ecosystems.";
    license = lib.licenses.isc;
    homepage = "https://mike-burns.com/project/setrb/";
    platforms = lib.platforms.unix;
  };
}
