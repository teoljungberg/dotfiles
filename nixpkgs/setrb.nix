{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "setrb";
  version = "0.3";

  src = fetchzip {
    url = "https://mike-burns.com/project/setrb/setrb-0.3.tar.gz";
    sha256 = "0jgigkvlz1c64dx6rha6jmxaw7s85sydsmvh2njhn5359yax4ilk";
  };

  meta = {
    description = "setrb(1) switches Ruby ecosystems.";
    license = stdenv.lib.licenses.isc;
    homepage = "https://mike-burns.com/project/setrb/";
    platforms = stdenv.lib.platforms.unix;
  };
}
