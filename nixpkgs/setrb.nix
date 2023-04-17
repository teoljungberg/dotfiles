{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
, lib ? pkgs.lib
}:

stdenv.mkDerivation rec {
  pname = "setrb";
  version = "0.3.2";

  src = fetchTarball {
    url = "https://mike-burns.com/project/setrb/setrb-${version}.tar.gz";
    sha256 = "199wwli9q25fy1vs3mjqs5db02w3cbnnwfknyld94796n53ndb9p";
  };

  meta = {
    description = "setrb(1) switches Ruby ecosystems.";
    license = lib.licenses.isc;
    homepage = "https://mike-burns.com/project/setrb/";
    platforms = lib.platforms.unix;
  };
}
