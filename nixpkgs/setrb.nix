{ pkgs ? (import <nixpkgs> { })
, stdenv ? pkgs.stdenv
, lib ? pkgs.lib
, fetchurl ? pkgs.fetchurl
}:

stdenv.mkDerivation {
  pname = "setrb";
  version = "0.3.1";

  src = fetchurl {
    url = "https://mike-burns.com/project/setrb/setrb-0.3.1.tar.gz";
    sha256 = "K9mB/LSIkNeXa+8JNP5VsK8iXq6Hy4yEPZTatSPSMW0=";
  };

  meta = {
    description = "setrb(1) switches Ruby ecosystems.";
    license = lib.licenses.isc;
    homepage = "https://mike-burns.com/project/setrb/";
    platforms = lib.platforms.unix;
  };
}
